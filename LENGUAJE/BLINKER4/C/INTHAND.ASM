;
;         95.06.22            INTHAND.ASM 
;         
;         Contrived example of real and protected mode interrupt handlers
;
.model large
.286

public	_inithandler
public	_realhandler
public	_prothandler

extrn	DosLockSeg:far
extrn	DosCreateDSAlias:far
extrn	DosAllocRealSeg:far
extrn	DosFreeSelector:far

.code

protchar  db        '.'                 ; Prot mode character to display
realchar  db        '-'                 ; Real mode character to display

protseg   dw        0                   ; Prot mode data buffer segment
realseg   dw        0                   ; Real mode data buffer segment

_inithandler:                           ; INITIALISE HANDLERS
          push      bp                  ; Save BP
          mov       bp,sp               ; Set up stack frame
          sub       sp,2                ; Leave space for local variable
          push      cs                  ; Pass the current code segment
          call      far ptr DosLockSeg  ; Lock the interrupt handler
          push      cs                  ; Pass the current code segment
          lea       ax,[bp-2]           ; Point to local variable
          push      ss                  ; Pass its segment
          push      ax                  ; Pass its offset
          call      far ptr DosCreateDSAlias ; Create a data alias for code
          mov       ax,1000h            ; Size of buffer
          push      ax                  ; Pass it
          mov       ax,offset realseg   ; Where to put real mode address
          push      [bp-2]              ; Pass the segment
          push      ax                  ; Pass it
          mov       ax,offset protseg   ; Where to put prot mode address
          push      [bp-2]              ; Pass the segment
          push      ax                  ; Pass it
          call      far ptr DosAllocRealSeg ; Allocate it
          push      [bp-2]              ; Pass the data alias
          call      far ptr DosFreeSelector ; Free the data alias
          pop       bp                  ; Restore BP
          retf                          ; All done
_realhandler:                           ; REAL MODE HANDLER
          pusha                         ; Save all registers
          mov       ax,cs:[realseg]     ; Get real mode buffer segment
          mov       dl,cs:[realchar]    ; Get character to display
          jmp       short commonhandler ; Jump to common handler
_prothandler:                           ; PROTECTED MODE HANDLER
          pusha                         ; Save all registers
          mov       ax,cs:[protseg]     ; Get prot mode buffer segment
          mov       dl,cs:[protchar]    ; Get character to display
commonhandler:                          ; COMMON HANDLER
          push      ds                  ; Save DS
          mov       ds,ax               ; Set up the buffer segment
          mov       ah,0eh              ; Display teletype
          mov       al,dl               ; Get the character
          int       10h                 ; Display it
;           ...                         ; HANDLE THE INTERRUPT
          pop       ds                  ; Restore DS
          popa                          ; Restore the registers
          iret                          ; Finished

end
