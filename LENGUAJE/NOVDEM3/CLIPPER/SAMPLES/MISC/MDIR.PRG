
// a sort of NDIR / Xtree type program to list directories and files
// and change their information etc.
//
// usage: MDIR < filespec >
//
// ie: MDIR SYS:PUBLIC\*.*
//
// by Goth
//

#include "fileio.ch"
#include "inkey.ch"
#define STACK_TOP      1
#define FILE_LINE      1
#define FILE_HANDLE    2
#define FILE_PATH      3
#define CR             chr(13)
#define LF             chr(10)
#define CRLF           chr(13)+chr(10)
#define MAX_LINE_LEN   80
#define fset( nHandle ) fseek( nHandle, 0, FS_SET )
#define fptr( nHandle ) fseek( nHandle, 0, FS_RELATIVE )
#define fend( nHandle ) fseek( nHandle, 0, FS_END )

LOCAL cName, cScanPath
PUBLIC aStack, cPath, nHandle

parameters cCommand

SET DATE BRITISH

aStack := {}

CLEAR SCREEN


cPath := DRVPTHGET( DRVCURGET() )
cPath := strtran( cPath, "/", "\" )

if ( cCommand == NIL )

  if( NWERRORGET() > 0 )
    ? "MDIR only works on Network drives"
    ? "Usage: MDIR <network filespec>"
    ?
    ? "Example: MDIR SYS:PUBLIC\*.*"
    quit
  endif

  cName := "\*"

else
  if ( ":" $ cCommand )
    if !( ":\" $ cCommand )
      cCommand := strtran( cCommand, ":", ":\" )
    endif
  endif
  if !( "\" $ cCommand )
    cName := "\"+upper(cCommand)
  else
    cPath := upper(left( cCommand, rat( "\", cCommand ) - 1 ))
    cName := upper(substr( cCommand, rat( "\", cCommand ) ))
  endif
endif

nHandle := fcreate( "MDIR.LOG", FC_NORMAL )

? "Scanning Directories, please be patient"
?
?

do while .T.

  cScanPath := cPath + cName    // cScanPath is the currently used directory

  FindDir( cPath + "\*" )       // get all sub directories and push to stack

  DispFile( cScanPath )         // list files from current directory

  cPath := PopStack()           // get next directory

  if empty( cPath )             // if nothing left on stack
    exit                        // exit loop
  endif

enddo

?

fclose( nHandle )

browser()

CLEAR SCREEN

DELETE FILE "MDIR.LOG"

QUIT


FUNCTION PushStack( cElement )   // pushes directory onto directory stack

aadd( aStack, "" )
ains( aStack, STACK_TOP )
aStack[STACK_TOP] := cElement

return( NIL )


FUNCTION PopStack()             // pops next directory from directory stack

LOCAL cElement := ""

if( len( aStack ) > 0 )
  cElement := aStack[STACK_TOP]
  adel( aStack, STACK_TOP )
endif

return( cElement )


FUNCTION FindDir( cScanPath )        // gets next list of directories and
                                     // pushes them on directory stack
LOCAL cName, nCounter

nCounter := 0

cName := DIRSUBDIRLST( cScanPath )

do while !( empty( cName ) )

  nCounter++

  PushStack( cPath +"\"+ cName )

  cName := DIRSUBDIRLST("")

enddo

asort( aStack, 1, nCounter )         // sort them into alphabetical order

return( NIL )


FUNCTION DispFile( cScanPath )

LOCAL cName, aFiles, nCounter, nOffset, nRow, cBuffer

aFiles := {}

nRow := row()

cBuffer := FSNMEGET()+"/"+cPath

@ nRow, 0 clear
@ nRow, 0 say "  "+cBuffer

FileWrite( cBuffer+CRLF )

cName := DIRFILLST( cScanPath )

do while !( empty( cName ) )

  @ nRow, 0 say Wheel()             // it looks pretty !

  nOffset := at( ".", cName )

  if nOffset > 0
    cName := ( padr( left( cName, nOffset -1 ), 8 )+substr( cName, nOffset ) )
  else
    cName := padr( cName, 12 )
  endif


  aadd( aFiles, cName )             // fill array with file names

  cName := DIRFILLST()

enddo

@ nRow, 0 say " "

asort( aFiles )                     // sort them into alphabetical order

for nCounter = 1 to len( aFiles )

@ nRow, 0 say Wheel()

  cBuffer :=  "  "+aFiles[nCounter]
  FileWrite( cBuffer+CRLF )

next

@ nRow, 0 say " "

cBuffer := FSNMEGET()+"/"+cPath
FileWrite( "*"+cBuffer+CRLF )

return( NIL )


FUNCTION Wheel()

LOCAL cValue
STATIC nCounter := 1

DO CASE
  CASE nCounter == 1
    cValue := "-"
  CASE nCounter == 2
    cValue := "\"
  CASE nCounter == 3
    cValue := "|"
  CASE nCounter == 4
    cValue := "/"
ENDCASE

nCounter := if( nCounter == 4, 1, ++nCounter )

return( cValue )


FUNCTION FileWrite( cBuffer )

LOCAL nLength, lRetVal

nLength := len( cBuffer )
lRetVal := .F.

if fwrite( nHandle, cBuffer, nLength ) == nLength
  lRetVal := .T.
endif

return( lRetVal )


FUNCTION FileInit( cFileName )

LOCAL aFStruct := array(3)

if ( aFStruct[FILE_HANDLE] := fopen( cFileName ) ) > 0
  fend( aFStruct[FILE_HANDLE] )
  GoFirst( aFStruct )
else
  aFStruct := NIL
endif

return( aFStruct )


FUNCTION GoFirst( aFStruct )

LOCAL cLine
LOCAL nHandle := aFStruct[FILE_HANDLE]

fset( nHandle )
FreadLn( nHandle, @cLine )
aFStruct[FILE_LINE] := cLine

if left( cLine, 1 ) != " "
  aFStruct[FILE_PATH] := strtran( cLine, "*", "")
endif

fset( nHandle )

return( NIL )


FUNCTION GoLast( aFStruct )

LOCAL nHandle := aFStruct[FILE_HANDLE]

fend( nHandle )
GoPrevLn( aFStruct )

return( NIL )


FUNCTION FreadLn( nHandle, cBuffer )

LOCAL nEOL, nRead, nSavePos

cBuffer := space( MAX_LINE_LEN )  // space for new data

nSavePos := fptr( nHandle )       // save current position of pointer

nRead := fread( nHandle, @cBuffer, MAX_LINE_LEN )  // read in buffer

if ( nEOL := at( CRLF, substr( cBuffer, 1, nRead ))) = 0
else                     // if there is a CR
  cBuffer := substr( cBuffer, 1, nEOL - 1 )    // trunkate line to nearest CR
  fseek( nHandle, nSavePos + nEOL + 1, FS_SET )    // move pointer to end of line
endif

return( nRead != 0 )


FUNCTION CurLine( aFStruct )
return( if(left(aFStruct[FILE_LINE],1) != "*",aFStruct[FILE_LINE],"" ) )


FUNCTION GoPrevLn( aFStruct )

LOCAL nHandle, nOrigPos, nMaxRead, nNewPos, lMoved, cBuffer, nWhereCRLF
LOCAL nPrev, cTemp

nHandle := aFStruct[FILE_HANDLE]   // get file handle
nOrigPos := fptr( nHandle )        // get current file pointer

if nOrigPos == 0                   // is it at beginning of file
  lMoved := .F.                    // yes then can't go back
else
  lMoved := .T.
  fseek( nHandle, -2, FS_RELATIVE ) // move file pointer back one byte
  cTemp := space(2)                 // set up buffer
  fread( nHandle, @cTemp, 2)        // read in one character
  if cTemp == CRLF                    // is it CR
    fseek( nHandle, -2, FS_RELATIVE ) // yes go back another character
  endif
  nMaxRead := min( MAX_LINE_LEN, fptr( nHandle ) )  // whats less max length or file pointer pos
  cBuffer := space( nMaxRead )                      // set up buffer
  nNewPos := fseek( nHandle, -nMaxRead, FS_RELATIVE ) // move back by buffer length
  fread( nHandle, @cBuffer, nMaxRead )
  nWhereCRLF := rat( CRLF, cBuffer )    // find the last CR
  if nWhereCRLF == 0                  // if there isnt one
    nPrev := nNewPos                  // save new position
    aFStruct[FILE_LINE] := cBuffer    // copy buffer
  else
    nPrev := nNewPos + nWhereCRLF + 1             // point to first char after lst CR
    aFStruct[FILE_LINE] := substr( cBuffer, nWhereCRLF + 2 )  // copy sub buffer
  endif
  fseek( nHandle, nPrev, FS_SET )     // set pointer to beginning of current line

  if left( aFStruct[FILE_LINE], 1 ) != " "
    aFStruct[FILE_PATH] := strtran(aFStruct[FILE_LINE], "*", "")
  endif

endif

return( lMoved )


FUNCTION FileSkip( nNum, aFStruct )

LOCAL nSkipped := 0

if nNum > 0
  do while nSkipped != nNum .AND. GoNextLn( aFStruct )
    nSkipped++
  enddo
else
  do while nSkipped != nNum .AND. GoPrevLn( aFStruct )
    nSkipped--
  enddo
endif

return( nSkipped )


FUNCTION GoNextLn( aFStruct )

LOCAL nHandle, nSavePos, cBuffer, lMoved, nNewPos

nHandle := aFStruct[FILE_HANDLE]      // get handle
nSavePos := fptr( nHandle )           // save position
cBuffer := " "

fseek( nHandle, len( aFStruct[FILE_LINE]) + 2, FS_RELATIVE ) // len of current line + 1
nNewPos := fptr( nHandle )            // move pointer to beginning of next line

if FreadLn( nHandle, @cBuffer )       // read in new buffer
  lMoved := .T.                       // moved is now .T.
  aFStruct[FILE_LINE] := cBuffer      // transfer buffer
  fseek( nHandle, nNewPos, FS_SET )   // set pointer back to beginning of current line
else
  lMoved := .F.                       // unable to move
  fseek( nHandle, nSavePos, FS_SET )  // put pointer back to where it was
endif

  if left( aFStruct[FILE_LINE], 1 ) != " "
    aFStruct[FILE_PATH] := strtran(aFStruct[FILE_LINE],"*","")
  endif

return( lMoved )


FUNCTION Browser()

LOCAL oB, oBc, nKey, lConfirm, aFStruct, lExit, cArea
LOCAL nTop, nLeft, nBottom, nRight
LOCAL cPathNear, cPathFar, lDir
LOCAL cDate, cTime, cName, cADate, cATime, cAName, cMDate, cMTime, cMName
LOCAL cACDate, cMask, cAtt, lOpen
LOCAL lIsV3

nTop := 2
nLeft := 46
nBottom := 16
nRight := 78

lIsV3 := ( val(left(alltrim(NWVERNUMGET()),1)) == 3 )

CLEAR SCREEN

aFStruct := FileInit( "MDIR.LOG" )

lConfirm := SET( _SET_CONFIRM, .t. )

@ 0, 0 to maxrow()-1, maxcol() double

oB := TBrowseNew( 1, 1, maxrow() - 2 , maxcol() - 1 )
ob:colorSpec := "W/N, B+/W, W+/B, R+/N, B+/W, B/W, W/B"
oBc := TBColumnNew(, { || CurLine( aFStruct ) } )
oBc:width := 80
oBc:colorBlock := { | cLine | if( left( cLine, 1 ) != " " , {4,5}, {1,2} ) }

oB:addColumn( oBc )

oB:goTopBlock    := { || GoFirst( aFStruct ) }
oB:goBottomBlock := { || GoLast( aFStruct ) }
oB:skipBlock     := { | n | FileSkip( n, aFStruct ) }

lExit := .F.

cPathFar := ""
cPathNear := ""

do while !lExit

  do while !oB:stabilize()
  enddo

  if aFStruct[FILE_PATH] == strtran(aFStruct[FILE_LINE],"*","" )
    cPathFar := aFStruct[FILE_PATH]
  else
    cPathFar := aFStruct[FILE_PATH]+"\"+ strtran(aFStruct[FILE_LINE], " ", "" )
  endif

  lDir := if( aFStruct[FILE_LINE] == aFStruct[FILE_PATH], .T., .F. )

  @ maxrow(), 1 clear to maxrow(), 79
  @ maxrow(), 1 say ltrim( cPathFar )

  cPathNear := substr( cPathFar, at( "/", cPathFar ) + 1 )

  cArea := savescreen( nTop, nLeft, nBottom, nRight )
  @ nTop, nLeft clear to nBottom, nRight
  @ nTop, nLeft to nBottom, nRight

  SET COLOR TO "BG/N, N/W"

  @ nTop+1, nLeft+1  say if( lDir, "Directory Name: ", "File Name     : " )
  @ nTop+2, nLeft+1  say "Date Created  : "
  @ nTop+3, nLeft+1  say "Time Created  : "
  @ nTop+4, nLeft+1  say if( lDir, "Dir Owner     : ", "File Owner    : " )
  @ nTop+5, nLeft+1  say "Date Archived : "
  @ nTop+6, nLeft+1  say "Time Archived : "
  @ nTop+7, nLeft+1  say "Archived By   : "
  @ nTop+8, nLeft+1  say "Date Modified : "
  @ nTop+9, nLeft+1  say "Time Modified : "
  @ nTop+10, nLeft+1 say "Modified By   : "
  @ nTop+11, nLeft+1 say "Last Accessed : "
  @ nTop+12, nLeft+1 say "Rights Mask   : "
  @ nTop+13, nLeft+1 say "Attributes "

 if !empty( CurLine( aFStruct )) .AND. right( cPathNear, 1 ) != ":"

    lOpen := ( !(lDir) .AND. ( FILOPNCONLST( cPathNear, 1 ) > 0 ) )

    if( lOpen )
      SET COLOR TO "G/N, N/W"
    else
      SET COLOR TO "GR+/N, N/W"
    endif

    @ nTop+1, nLeft+17  say if( lDir, DIRSUBDIRLST( cPathNear ), DIRFILLST( cPathNear ) )

    SET COLOR TO "GR+/N, N/W"

    @ nTop+2, nLeft+17  say cDate := if( lDir, dtoc(DIRCREDTEGET()), dtoc(FILCREDTEGET()) )
    @ nTop+3, nLeft+17  say cTime := if( lDir, DIRCRETMEGET(), if( lIsV3, FILCRETMEGET(), "N/A" ) )
    @ nTop+4, nLeft+17  say cName := if( lDir, OBJNMEGET( DIROWNIDGET()), OBJNMEGET( FILOWNIDGET()) )
    @ nTop+5, nLeft+17  say cADate := if( lDir, if( lIsV3, dtoc(DIRARCDTEGET()), "N/A" ), dtoc(FILARCDTEGET()) )
    @ nTop+6, nLeft+17  say cATime := if( lDir, if( lIsV3, DIRARCTMEGET(), "N/A" ), FILARCTMEGET() )
    @ nTop+7, nLeft+17  say cAName := if( lDir, if( lIsV3, OBJNMEGET(DIRARCIDGET()), "N/A" ), if( lIsV3, OBJNMEGET(FILARCIDGET()), "N/A" ) )
    @ nTop+8, nLeft+17  say cMDate := if( lDir, if( lIsV3, dtoc(DIRMODDTEGET()), "N/A" ), dtoc(FILMODDTEGET()) )
    @ nTop+9, nLeft+17  say cMTime := if( lDir, if( lIsV3, DIRMODTMEGET(), "N/A" ), FILMODTMEGET() )
    @ nTop+10, nLeft+17 say cMName := if( lDir, "N/A", if( lIsV3, OBJNMEGET(FILMODIDGET()), "N/A" ) )
    @ nTop+11, nLeft+17 say cACDate := if( lDir, "N/A", dtoc(FILACCDTEGET()) )
    @ nTop+12, nLeft+17 say cMask := if( lDir, NOVRGTSTR( DIRIRMSKGET()), if( lIsV3, NOVRGTSTR( FILIRMSKGET()), "N/A" ) )
    @ nTop+13, nLeft+12 say cAtt := NOVATTSTR(if( lDir, DIRATTGET(), FILATTGET() ) )

  endif

  SET COLOR TO

  nKey := inkey(0)

  restscreen( nTop, nLeft, nBottom, nRight, cArea )

  do case
    case ( nKey == K_RETURN .and. oB:stable() )

      cArea := savescreen( nTop, nLeft, nBottom, nRight )
      @ nTop, nLeft clear to nBottom, nRight
      @ nTop, nLeft to nBottom, nRight

      SET COLOR TO "BG/N, N/W"

      @ nTop+1, nLeft+1  say if( lDir, "Directory Name: ", "File Name     : " )
      @ nTop+2, nLeft+1  say "Date Created  : "
      @ nTop+3, nLeft+1  say "Time Created  : "
      @ nTop+4, nLeft+1  say if( lDir, "Dir Owner     : ", "File Owner    : " )
      @ nTop+5, nLeft+1  say "Date Archived : "
      @ nTop+6, nLeft+1  say "Time Archived : "
      @ nTop+7, nLeft+1  say "Archived By   : "
      @ nTop+8, nLeft+1  say "Date Modified : "
      @ nTop+9, nLeft+1  say "Time Modified : "
      @ nTop+10, nLeft+1 say "Modified By   : "
      @ nTop+11, nLeft+1 say "Last Accessed : "
      @ nTop+12, nLeft+1 say "Rights Mask   : "
      @ nTop+13, nLeft+1 say "Attributes "

      if !empty( CurLine( aFStruct )) .AND. right( cPathNear, 1 ) != ":"

        cName := padr( cName, 15 )
        cAName := padr( cAName, 15 )
        cMName := padr( cMName, 15 )

        SET COLOR TO "GR+/N, B/W, N, N, GR+/W"

        @ nTop+1, nLeft+17  say if( lDir, DIRSUBDIRLST( cPathNear ), DIRFILLST( cPathNear ) )
        @ nTop+2, nLeft+17  get cDate picture "@D"
        if lIsV3 .OR. lDir
          @ nTop+3, nLeft+17  get cTime picture "99:99:99"
        endif
        @ nTop+4, nLeft+17  get cName picture "@!"
        if lIsV3 .OR. !lDir
          @ nTop+5, nLeft+17  get cADate picture "@D"
          @ nTop+6, nLeft+17  get cATime picture "99:99:99"
        endif
        if lIsV3
          @ nTop+7, nLeft+17  get cAName picture "@!"
        endif
        if lIsV3 .OR. !lDir
          @ nTop+8, nLeft+17  get cMDate picture "@D"
          @ nTop+9, nLeft+17  get cMTime picture "99:99:99"
        endif
        if lIsV3 .AND. !lDir
          @ nTop+10, nLeft+17 get cMName picture "@!"
        endif
        if !lDir
          @ nTop+11, nLeft+17 get cACDate picture "@D"
        endif
        if lIsV3 .OR. lDir
          @ nTop+12, nLeft+17 get cMask
        endif
        if lIsV3 .OR. !lDir
          @ nTop+13, nLeft+12 get cAtt
        endif

        READ

        if lastkey() != K_ESC

          if !lDir
            FILCREDTESET( cPathNear, ctod( cDate ) )
            FILCRETMESET( cPathNear, cTime )
            FILOWNIDSET( cPathNear, OBJIDGET( alltrim( cName ), 1 ) )
            FILARCDTEGET( cPathNear, ctod( cADate ) )
            FILARCTMESET( cPathNear, cATime )
            FILARCIDSET( cPathNear, OBJIDGET( alltrim( cAName ), 1 ) )
            FILMODDTESET( cPathNear, ctod( cMDate ) )
            FILMODTMESET( cPathNear, cMTime )
            FILMODIDSET( cPathNear, OBJIDGET( alltrim( cMName ), 1 ) )
            FILACCDTESET( cPathNear, ctod( cACDate ) )
            FILIRMSKSET( cPathNear, NOVRGTSTR( cMask ) )
            FILATTSET( cPathNear, NOVATTSTR( cAtt ) )
          else
            DIRCREDTESET( cPathNear, ctod( cDate ) )
            DIRCRETMESET( cPathNear, cTime )
            DIROWNIDSET( cPathNear, OBJIDGET( alltrim( cName ), 1 ) )
            DIRARCDTESET( cPathNear, ctod( cADate ) )
            DIRARCTMESET( cPathNear, cATime )
            DIRARCIDSET( cPathNear, OBJIDGET( alltrim( cAName ), 1 ) )
            DIRMODDTESET( cPathNear, ctod( cMDate ) )
            DIRMODTMESET( cPathNear, cMTime )
            DIRIRMSKSET( cPathNear, NOVRGTSTR( cMask ) )
            DIRATTSET( cPathNear, NOVATTSTR( cAtt ) )
          endif

        endif

      endif

      SET COLOR TO

      restscreen( nTop, nLeft, nBottom, nRight, cArea )

    case ( nKey == K_DOWN );       oB:down()
    case ( nKey == K_UP );         oB:up()
    case ( nKey == K_PGDN );       oB:pageDown()
    case ( nKey == K_PGUP );       oB:pageUp()
    case ( nKey == K_CTRL_PGUP );  oB:goTop()
    case ( nKey == K_CTRL_PGDN );  oB:goBottom()
    case ( nKey == K_RIGHT );      oB:right()
    case ( nKey == K_LEFT );       oB:left()
    case ( nKey == K_HOME );       oB:home()
    case ( nKey == K_END );        oB:end()
    case ( nKey == K_CTRL_LEFT );  oB:panLeft()
    case ( nKey == K_CTRL_RIGHT ); oB:panRight()
    case ( nKey == K_CTRL_HOME );  oB:panHome()
    case ( nKey == K_CTRL_END );   oB:panEnd()
    case ( nKey == K_ESC );        lExit := .T.
  endcase


enddo

SET( _SET_CONFIRM, lConfirm )

fclose( aFStruct[FILE_HANDLE] )

return( Nil )



