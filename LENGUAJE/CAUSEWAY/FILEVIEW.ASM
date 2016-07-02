; FILEVIEW.ASM -- Clipper-callable 32-bit text file viewer
;
; Function:   CWFileView()
;
; Syntax:     CWFileView( cFile, nTop, nLeft, nBottom, nRight, bCallBack )
;
; Arguments:  cFile is the name of the file to view.
;
;             nTop, nLeft, nBottom, and nRight are the screen coordinates
;             that define where the file will be displayed.
;
;             bCallBack is a code block that will be evaluated each time
;             the screen display is refreshed.  The first time it is
;             invoked, it receives the total number of lines and columns in
;             the file.  In subsequent invocations, it receives the current
;             line and column.  The codeblock should return a numeric value
;             that informs the file viewer of the desired action (see
;             FILEVIEW.CH for details).
;
; Returns:    A numeric value indicating success or failure:
;
;              0 == Success
;             -1 == Could not open file
;             -2 == Insufficient memory to buffer file
;
; Notes:      This routine is not particularly optimized because I was
;             aiming mainly for clarity.  The purpose is to demonstrate
;             how 32-bit programming can be used with Clipper.  I tried to
;             make use of some neat 386 stuff, like 32-bit registers,
;             extra segment registers, zero-extended register loads, and so
;             on.  The lack of optimization doesn't seem to matter because
;             it runs plenty fast on my 486DX-33.  Your mileage may vary.
;
;             This routine should work with files up to 4GB, although
;             5MB is the largest I tested.  In most "real world" cases
;             I'd bet text files seldom get even that large.
; ------------------------------------------------------------------------------

P386                                              ; Enable 386 instructions
IDEAL                                             ; Invoke IDEAL mode

Public    CWFileView                              ; Clipper-callable name

Extrn     __ParC:Far                              ; Various internal and
Extrn     __ParNI:Far                             ; API routines
Extrn     __RetNI:Far

Extrn     __fldd:Far
Extrn     __ftol:Far

Extrn     __gtBox:Far
Extrn     __gtWriteAt:Far
Extrn     __gtDispBegin:Far
Extrn     __gtDispEnd:Far

Extrn     __evalNew:Far
Extrn     __evalLaunch:Far
Extrn     __evalRelease:Far
Extrn     __evalPutParam:Far

Extrn     __itemParam:Far
Extrn     __itemPutNL:Far
Extrn     __itemGetNL:Far
Extrn     __itemGetND:Far
Extrn     __itemRelease:Far
Extrn     __itemType:Far
Extrn     __itemNew:Far

Segment   LocalData Page                          ; Local data segment

RetVal    DW        ?                             ; Function's return value
Handle    DW        ?                             ; File handle
ByteCount DD        ?                             ; # of bytes in file

Label     FilePtr   FWord                         ; Pointer to file buffer
FileOfs   DD        ?                             ; File buffer offset
FileSel   DW        ?                             ; File buffer selector

TableSel  DW        ?                             ; Offset table selector

Top       DW        ?                             ; Screen coordinates
Left      DW        ?
Bottom    DW        ?
Right     DW        ?

RowCount  DD        ?                             ; # of lines in file
ColCount  DD        ?                             ; # of columns in file
TopRow    DD        ?                             ; Current 1st row
Margin    DD        ?                             ; Current 1st column

LineBuf   DB        256 dup( ? )                  ; Work buffer for one line
LineLen   DW        ?                             ; # of columns in display
PageLen   DW        ?                             ; # of rows in display

codeBlock DW        ?                             ; Supplied codeblock

Param1    DD        ?                             ; Params passed to
Param2    DD        ?                             ; the codeblock

Box       DB        9 dup( 32 )                   ; Used to clear display

Ends      LocalData

Segment   CauseWay  Word      Public    "CODE"
          Assume    CS:CauseWay,GS:LocalData

Proc      CWFileView          Far

          Push      ESI                           ; Save ESI . .
          Push      EDI                           ; . . . and EDI for Clipper
          Enter     14,0                          ; Create a stack frame

          ; First we'll clear out any old junk left in the local
          ; data segment from a previous call.

          Push      LocalData                     ; Make local data segment
          Pop       ES                            ; addressable by ES
          Mov       CX,Offset LocalData:Box       ; Get byte count
          Mov       AL,0                          ; Clear AL
          Mov       DI,Offset LocalData:RetVal    ; Start of local data seg
          Rep       Stosb                         ; Clear local data vars

          ; Now ask Clipper for the file name.

          Push      1                             ; Specify 1st param
          Call      __ParC                        ; Get file name
          Add       SP,2                          ; Realign stack

          ; Attempt to open the file.

          Push      DS                            ; Save DS
          Mov       DS,DX                         ; Set DS:DX to point
          Mov       DX,AX                         ; to file name
          Mov       AX,3D00h                      ; DOS service -- open file
          Int       21h                           ; Call DOS
          Pop       DS                            ; Restore DS
          Push      LocalData                     ; Make local data seg
          Pop       GS                            ; addressable by GS
          JNC       @@Open                        ; If file open, continue
          Mov       [GS:RetVal],-1                ; Set return value . . .
          Jmp       @@Exit                        ; . . . and bail

          ; If the file was opened, we determine the number of bytes
          ; contained therein.

@@Open:   Mov       [GS:Handle],AX                ; Store handle
          Mov       BX,AX                         ; Move handle to BX
          Mov       AX,4202h                      ; DOS service -- go to EOF
          Xor       CX,CX                         ; Set file offset to zero
          Mov       DX,CX
          Int       21h                           ; Call DOS

          ; Now allocate a 32-bit memory block and selector to store
          ; the file contents.  A 32-bit selector can hold up to
          ; 4GB, so we can have the entire file in memory.

          Push      DX                            ; Move file byte count . . .
          Push      AX
          Pop       ECX                           ; . . . into ECX
          Mov       [GS:ByteCount],ECX            ; Store byte count
          Inc       ECX                           ; Make room for final
          Inc       ECX                           ; CRLF if necessary
          Mov       AX,0FF0Ch                     ; Extender -- GetMem32
          Int       31h                           ; Call extender
          JNC       @@Read                        ; If success, continue
          Mov       [GS:RetVal],-2                ; Not enough memory . . .
          Jmp       @@Exit                        ; . . . so bail

@@Read:   Mov       [GS:FileSel],BX               ; Store the selector . . .
          Mov       [GS:FileOfs],0                ; . . . and offset is zero

          ; Now ask Clipper for the codeblock and store it.

          Push      GS                            ; Save GS
          Push      6                             ; Specify param #6
          Call      __itemParam                   ; Get code block
          Add       SP,2                          ; Realign stack
          Pop       GS                            ; Restore GS
          Mov       [GS:codeBlock],AX             ; Save codeblock

          ; Reset the file pointer to the begining of the file
          ; in preparation for reading it.

          Mov       AX,4200h                      ; DOS service -- go to BOF
          Mov       BX,[GS:Handle]                ; Supply handle
          Xor       CX,CX                         ; Set file offset to zero
          Mov       DX,CX
          Int       21h                           ; Call DOS

          ; Now read the file 0F000h bytes at a time, until we hit EOF.
          ; The bytes read are loaded into our previously allocated 32-bit
          ; memory block.

@@Next:   Push      DS                            ; Save DS
          Mov       AH,3Fh                        ; DOS service -- read file
          Mov       BX,[GS:Handle]                ; Supply handle
          Mov       DS,[GS:FileSel]               ; Supply file selector
          Mov       EDX,[GS:FileOfs]              ; Supply file offset
          Mov       CX,0F000h                     ; Set bytes to read
          Int       21h                           ; Call DOS
          Pop       DS                            ; Restore DS
          JC        @@Full                        ; If CF set, read complete
          Cmp       AX,0F000h                     ; Did we get 0F000h bytes?
          JNE       @@Full                        ; If not, read complete
          Add       [GS:FileOfs],0F000h           ; Bump offset for next read
          Jmp       @@Next                        ; Read next block

@@Full:   Mov       [GS:FileOfs],0                ; Reset file offset to zero
          Mov       AH,3Eh                        ; DOS service -- close file
          Mov       BX,[GS:Handle]                ; Supply handle
          Int       21h                           ; Call DOS

          ; Next step is to scan the file to count how many lines it
          ; it contains.  Each time a CRLF pair is found, the line
          ; count is incremented.
          ;
          ; In addition, each line's length is checked so that when
          ; finished, we'll know what the longest line is.

          Mov       AL,13                         ; Scan for CR
          Mov       ECX,[GS:ByteCount]            ; Get file byte count
          LES       EDI,[GS:FilePtr]              ; ES:EDI points to mem block
          Cmp       [Word Ptr ES:EDI + ECX - 2],0A0Dh
          JE        @@Count
          Mov       [Word Ptr ES:EDI + ECX],0A0Dh ; Put CRLF on last line
          Inc       ECX                           ; Increment byte count
          Inc       ECX                           ; Increment byte count
          Mov       [GS:ByteCount],ECX            ; Store new byte count

@@Count:  Inc       [GS:RowCount]                 ; Increment row count
          Mov       EBX,EDI                       ; Load EBX with current EDI
@@Scan:   DB        66h                           ; Use prefix bytes to force
          DB        67h                           ; SCASB to use ECX and EDI
          Repne     Scasb                         ; Scan block for CR
          Cmp       [Byte Ptr ES:EDI],10          ; Is next byte a LF?
          JNE       @@Scan                        ; If not, keep scanning
          Sub       EBX,EDI                       ; Get # of bytes in line
          Neg       EBX                           ; Convert to positive #
          Dec       EBX                           ; Disregard CR
          Cmp       EBX,[GS:ColCount]             ; Is this line longest?
          JBE       @@NewLine                     ; If not, move on
          Mov       [GS:ColCount],EBX             ; Store line length
@@NewLine:Inc       EDI                           ; Skip past LF
          Dec       ECX                           ; Remove LF from byte count
          JNZ       @@Count                       ; Do next byte

          ; Now that we know the number of lines in the file, we'll
          ; allocate a memory block to contain a table of offsets that
          ; point to the beginning of each line.  This will boost performance
          ; considerably when the file is being viewed, because we don't
          ; have to keep scanning for the beginning of each line -- we just
          ; load the next offset from the table.

@@Alloc:  Mov       ECX,[GS:RowCount]             ; Get line count
          SHL       ECX,2                         ; Multiply by four
          Mov       AX,0FF0Ch                     ; Extender -- GetMem32
          Int       31h                           ; Call extender
          JNC       @@LoadEm                      ; Success -- continue
          Mov       [GS:RetVal],-2                ; Not enough memory . . .
          Jmp       @@Exit                        ; . . . so bail

@@LoadEm: Mov       [GS:TableSel],BX              ; Store table selector
          Mov       FS,BX                         ; FS points to table
          Xor       EDX,EDX                       ; Use EDX for table offset
          Mov       ECX,[GS:ByteCount]            ; Get file byte count
          LES       EDI,[GS:FilePtr]              ; ES:EDI points to mem block
          Mov       AL,13                         ; Scan for CR
@@NextOfs:Mov       [DWord Ptr FS:EDX],EDI        ; Store line's offset
@@Scan2:  DB        66h                           ; Use prefix bytes to force
          DB        67h                           ; SCASB to use ECX and EDI
          Repne     Scasb                         ; Scan block for CR
          Cmp       [Byte Ptr ES:EDI],10          ; Look for LF
          JNE       @@Scan2                       ; If not, keep scanning
          Add       EDX,4                         ; Found EOL, add 4 to offset
          Inc       EDI                           ; Skip past LF
          Dec       ECX                           ; Remove LF from byte count
          JNZ       @@NextOfs                     ; Continue scanning

          ; Next we'll retrieve the screen coordinates from Clipper.

@@Coord:  Push      5                             ; Specify right coord
          Call      __ParNI                       ; Get value
          Add       SP,2                          ; Realign stack
          Push      AX                            ; Save for later

          Push      4                             ; Specify bottom coord
          Call      __ParNI                       ; Get value
          Add       SP,2                          ; Realign stack
          Push      AX                            ; Save for later

          Push      3                             ; Specify left coord
          Call      __ParNI                       ; Get value
          Add       SP,2                          ; Realign stack
          Push      AX                            ; Save for later

          Push      2                             ; Specify top coord
          Call      __ParNI                       ; Get value
          Add       SP,2                          ; Realign stack

          Push      LocalData                     ; Make local data seg
          Pop       GS                            ; addressable by GS

          Mov       [GS:Top],AX                   ; Save screen coords
          Pop       [GS:Left]
          Pop       [GS:Bottom]
          Pop       [GS:Right]

          Mov       AX,[GS:Right]                 ; Load right coord
          Sub       AX,[GS:Left]                  ; Subtract left coord
          Inc       AX                            ; Add 1
          Mov       [GS:LineLen],AX               ; Result is line length

          Mov       AX,[GS:Bottom]                ; Load bottom coord
          Sub       AX,[GS:Top]                   ; Subtract top coord
          Inc       AX                            ; Add 1
          Mov       [GS:PageLen],AX               ; Result is page length

          Mov       [GS:TopRow],0                 ; Init top row and left
          Mov       [GS:Margin],0                 ; column to zero

          Mov       EAX,[GS:RowCount]             ; Load row count
          Mov       [GS:Param1],EAX               ; Store in first param
          Mov       EAX,[GS:ColCount]             ; Load column colunt
          Mov       [GS:Param2],EAX               ; Store in second param

@@Refresh:Call      Refresh                       ; Do the main thang

          ; Now we'll evaluate the supplied code block, passing two
          ; arguments, and use the return value to determine what happens
          ; next.

          Push      0                             ; Ask Clipper for a . . .
          Call      __itemNew                     ; . . . null ITEM
          Add       SP,2                          ; Realign stack

          Push      LocalData                     ; Make local data seg
          Pop       GS                            ; addressable by GS
          Movzx     EAX,AX                        ; Load ITEM into EAX
          Movzx     EDX,[GS:codeBlock]            ; Load codeblock into EDX
          Mov       ECX,[DWord Ptr EDX]           ; Make copy of codeblock
          Mov       [DWord Ptr EAX],ECX
          Mov       ECX,[DWord Ptr EDX + 4]
          Mov       [DWord Ptr EAX + 4],ECX
          Mov       ECX,[DWord Ptr EDX + 8]
          Mov       [DWord Ptr EAX + 8],ECX
          Mov       CX,[Word Ptr EDX + 12]
          Mov       [Word Ptr EAX + 12],CX

          Push      AX                            ; Put copy on stack
          LEA       AX,[BP - 14]                  ; Get address of EVALINFO
          Push      SS                            ; structure on stack
          Push      AX
          Call      __evalNew                     ; Init the EVALINFO struct

          Push      LocalData                     ; Make GS point to our
          Pop       GS                            ; local data seg

          Push      [GS:Param1]                   ; Create an ITEM containing
          Push      0                             ; our first parameter
          Call      __itemPutNL
          Add       SP,6

          Push      AX                            ; Put first parameter into
          LEA       AX,[BP - 14]                  ; EVALINFO structure
          Push      SS
          Push      AX
          Call      __evalPutParam
          Add       SP,6

          Push      LocalData                     ; Make GS point to our
          Pop       GS                            ; local data seg

          Push      [GS:Param2]                   ; Create an ITEM containing
          Push      0                             ; our second parameter
          Call      __itemPutNL
          Add       SP,6

          Push      AX                            ; Put second parameter into
          LEA       AX,[BP - 14]                  ; EVALINFO structure
          Push      SS
          Push      AX
          Call      __evalPutParam
          Add       SP,6

          Call      __evalLaunch                  ; Evaluate the code block
          Push      AX                            ; Save the return value

          LEA       AX,[BP - 14]                  ; Release all ITEMs in
          Push      SS                            ; the EVALINFO structure
          Push      AX
          Call      __evalRelease
          Add       SP,4

          Call      __itemType                    ; Get data type of the
                                                  ; codeblock's return value

          Test      AX,2048                       ; Is it a double?
          JNZ       @@asDbl                       ; If so, get double
          Call      __itemGetNL                   ; Get long integer
          Jmp       Short @@Release

@@asDbl:  Call      __itemGetND                   ; Get double
          Mov       ES,DX                         ; Load pointer into ES:BX
          Mov       BX,AX
          Mov       AX,[Word Ptr ES:BX]           ; Store double on stack
          Mov       [Word Ptr BP - 8],AX          ; frame
          Mov       AX,[Word Ptr ES:BX + 2]
          Mov       [Word Ptr BP - 6],AX
          Mov       AX,[Word Ptr ES:BX + 4]
          Mov       [Word Ptr BP - 4],AX
          Mov       AX,[Word Ptr ES:BX + 6]
          Mov       [Word Ptr BP - 2],AX
          LEA       BX,[BP - 8]                   ; DS:BX points to double
          Call      __fldd                        ; Call internal math stuff
          Call      __ftol                        ; to convert to long int

@@Release:Pop       CX                            ; Get return value ITEM
          Push      DX                            ; Save long integer
          Push      AX
          Push      CX                            ; Put ITEM on stack
          Call      __itemRelease                 ; Release it -- we're done
          Pop       AX                            ; Realign stack
          Pop       EAX                           ; Get return value back
          Add       SP,6                          ; Realign stack

          Push      LocalData                     ; Make local data seg
          Pop       GS                            ; addressable by GS

          ; Now we check the return value (a series of bit flags) to
          ; see which behaviors have been requested.

@@TOF:    Test      EAX,1                         ; TOF requested?
          JZ        @@BOF                         ; If not, go on
          Mov       [GS:TopRow],0                 ; Set top row to zero

@@BOF:    Test      EAX,2                         ; BOF requested?
          JZ        @@ToLeft                      ; If not, go on
          Mov       EDX,[GS:RowCount]             ; Get row count
          Dec       EDX                           ; TopRow is zero-relative
          Mov       [GS:TopRow],EDX               ; Store new TopRow

@@ToLeft: Test      EAX,4                         ; Left edge requested?
          JZ        @@ToRight                     ; If not, move on
          Mov       [GS:Margin],0                 ; Set margin to zero

@@ToRight:Test      EAX,8                         ; Right edge requested?
          JZ        @@Up                          ; If not, move on
          Mov       EDX,[GS:ColCount]             ; Get column count
          Dec       EDX                           ; Margin is zero-relative
          Mov       [GS:Margin],EDX               ; Store new Margin

@@Up:     Test      EAX,10h                       ; Scroll up requested?
          JZ        @@Down                        ; If not, move on
          Sub       [GS:TopRow],1                 ; Decrement TopRow
          ADC       [GS:TopRow],0                 ; If CF, it was already zero

@@Down:   Test      EAX,20h                       ; Scroll down requested?
          JZ        @@Left                        ; If not, move on
          Mov       EDX,[GS:RowCount]             ; Get row count
          Inc       [GS:TopRow]                   ; Increment TopRow
          Cmp       [GS:TopRow],EDX               ; Trying to go beyond EOF?
          JB        @@Left                        ; If not, okay
          Dec       [GS:TopRow]                   ; Otherwise, can't increment

@@Left:   Test      EAX,40h                       ; Scroll left requested?
          JZ        @@Right                       ; If not, move on
          Sub       [GS:Margin],1                 ; Decrement margin
          ADC       [GS:Margin],0                 ; If CF, it was already zero

@@Right:  Test      EAX,80h                       ; Scroll right requested?
          JZ        @@PgUp                        ; If not, move on
          Inc       [GS:Margin]                   ; Increment margin
          Mov       EDX,[GS:ColCount]             ; Get column count
          Cmp       [GS:Margin],EDX               ; Beyond right edge?
          JB        @@PgUp                        ; If not, okay
          Dec       [GS:Margin]                   ; Otherwise, can't increment

@@PgUp:   Test      EAX,100h                      ; PageUp requested?
          JZ        @@PgDn                        ; If not, move on
          Movzx     EDX,[GS:PageLen]              ; Get page length
          Sub       [GS:TopRow],EDX               ; Subtract from current row
          JNC       @@PgDn                        ; If no CF, go on
          Mov       [GS:TopRow],0                 ; Otherwise set to zero

@@PgDn:   Test      EAX,200h                      ; PageDown requested?
          JZ        @@PgLeft                      ; If not, move on
          Movzx     ECX,[GS:PageLen]              ; Get page length
          Mov       EDX,[GS:RowCount]             ; Get current row count
          Dec       EDX                           ; It's zero-relative
          Add       [GS:TopRow],ECX               ; Add to current row
          Cmp       [GS:TopRow],EDX               ; Past last row?
          JBE       @@PgRight                     ; If not, okay
          Mov       [GS:TopRow],EDX               ; Otherwise, set to last row

@@PgLeft: Test      EAX,400h                      ; PageLeft requested?
          JZ        @@PgRight                     ; If not, move on
          Movzx     EDX,[GS:LineLen]              ; Load line length
          Sub       [GS:Margin],EDX               ; Subtract from margin
          JNC       @@PgRight                     ; Tried to go past zero?
          Mov       [GS:Margin],0                 ; If so, set to zero

@@PgRight:Test      EAX,800h                      ; PageRight requested?
          JZ        @@NoMore                      ; If not, move on
          Movzx     EDX,[GS:LineLen]              ; Get line length
          Add       [GS:Margin],EDX               ; Add to margin
          Mov       EDX,[GS:ColCount]             ; Get column count
          Dec       EDX                           ; It's zero-relative . . .
          Dec       EDX                           ; and we want at least one
          Cmp       [GS:Margin],EDX               ; Margin too high?
          JBE       @@NoMore                      ; If not, go on
          Mov       [GS:Margin],EDX               ; Otherwise, set to max

@@NoMore: Test      EAX,10000h                    ; Exit requested?
          JNZ       @@Exit                        ; If so, bail
          Mov       EAX,[GS:TopRow]               ; Get current row
          Inc       EAX                           ; It's zero-relative
          Mov       [GS:Param1],EAX               ; Store in parameter 1
          Mov       EAX,[GS:Margin]               ; Get current column
          Inc       EAX                           ; It's zero-relative
          Mov       [GS:Param2],EAX               ; Store in parameter 2
          Jmp       @@Refresh                     ; Here we go again

          ; Here's the exit point, regardless of success or failure.
          ; Depending on how far the function was able to go, we may
          ; have anywhere from zero to three cleanup tasks to perform.

@@Exit:   Cmp       [GS:FileSel],0                ; Is file selector valid?
          JE        @@Done                        ; If not, quit
          Mov       AX,0FF0Fh                     ; Extender -- RelMem
          Mov       BX,[GS:FileSel]               ; Supply selector
          Int       31h                           ; Call extender

          Cmp       [GS:TableSel],0               ; Is table selector valid?
          JE        @@Done                        ; If not, quit
          Mov       AX,0FF0Fh                     ; Extender -- RelMem
          Mov       BX,[GS:TableSel]              ; Supply selector
          Int       31h                           ; Call extender

          Push      GS                            ; Save GS
          Push      [GS:codeBlock]                ; Put codeblock on stack
          Call      __itemRelease                 ; Free it
          Add       SP,2                          ; Realign stack
          Pop       GS                            ; Restore GS

@@Done:   Push      [GS:RetVal]                   ; Return value to Clipper
          Call      __RetNI
          Leave                                   ; Kill stack frame
          Pop       EDI                           ; Restore EDI and ESI
          Pop       ESI                           ; for Clipper
          RetF
Endp      CWFileView



          ; This is a local procedure that refreshes the display with
          ; the current file info.

Proc      Refresh   Near

          Call      __gtDispBegin                 ; Buffer screen I/O

          Push      LocalData                     ; Make local data seg
          Pop       GS                            ; addressable by GS

          ; Clear the display area by calling __gtBox with nothing
          ; but blank spaces.

          Push      GS                            ; Save GS
          Push      Offset LocalData:Box          ; Offset of box frame
          Push      [GS:Right]                    ; Supply coordinates
          Push      [GS:Bottom]
          Push      [GS:Left]
          Push      [GS:Top]
          Call      __gtBox                       ; Draw the box
          Add       SP,10                         ; Realign stack
          Pop       GS                            ; Restore GS

          Movzx     ECX,[GS:PageLen]              ; Get page length

          ; Now fill the display by looping and writing a line
          ; each time through the loop.

@@Top:    Push      ECX                           ; Save loop counter
          Add       ECX,[GS:TopRow]               ; Add top row
          Cmp       ECX,[GS:RowCount]             ; Beyond bottom of file?
          JA        @@Bottom                      ; If so, no display yet

          Mov       DS,[GS:FileSel]               ; Get file buffer selector
          Mov       FS,[GS:TableSel]              ; Get offset table selector
          Push      GS                            ; Move GS . . .
          Pop       ES                            ; . . . to ES
          Mov       ESI,[DWord Ptr FS:ECX * 4 - 4]; Get offset of current line
          Mov       EDI,Offset LocalData:LineBuf  ; Get offset of work buffer
          Mov       EBX,[GS:ByteCount]            ; Default to byte count
          JE        @@Calc                        ; If last line, use default
          Mov       EBX,[DWord Ptr FS:ECX * 4]    ; Otherwise, use next offset
@@Calc:   Dec       EBX                           ; Ignore LF
          Dec       EBX                           ; Ignore CR
          Add       ESI,[GS:Margin]               ; Add margin to offset
          Sub       EBX,ESI                       ; Calc byte count
          JBE       @@Bottom                      ; Nothing to write

          Push      ECX                           ; Save row indicator
          Movzx     ECX,[GS:LineLen]              ; Get line length
          Cmp       EBX,ECX                       ; Exceed line length?
          JBE       @@XFer                        ; If not, fine
          Mov       EBX,ECX                       ; # of bytes == line length
@@XFer:   Mov       ECX,EBX                       ; Dupe byte count
          DB        66h                           ; Use prefix bytes to make
          DB        67h                           ; MOVSB use 32-bit regs
          Rep       Movsb                         ; Copy bytes
          Pop       ECX                           ; Restore row indicator

          Push      SS                            ; Move SS to DS . . .
          Pop       DS                            ; . . . so DS is DGROUP
          Push      BX                            ; Put byte counter on stack
          Push      GS                            ; Put pointer to work
          Push      Offset LocalData:LineBuf      ; buffer on stack
          Push      [GS:Left]                     ; Supply left coord
          Sub       ECX,[GS:TopRow]               ; Calc upper coord
          Movzx     EAX,[GS:Top]
          Add       ECX,EAX

          Dec       ECX
          Push      CX
          Call      __gtWriteAt                   ; Write line
          Add       SP,6                          ; Realign stack
          Pop       GS                            ; Restore GS
          Add       SP,2                          ; Realign stack

@@Bottom: Pop       ECX                           ; Get loop counter back
          Dec       ECX                           ; Decrement it
          JNZ       @@Top                         ; Bail when we hit zero

          Push      SS                            ; Move SS to DS . . .
          Pop       DS                            ; . . . so DS is DGROUP
          Call      __gtDispEnd                   ; Flush pending screen I/O

          Push      LocalData                     ; Return with GS pointing
          Pop       GS                            ; to local data seg
          RetN
Endp      Refresh
Ends      CauseWay
End