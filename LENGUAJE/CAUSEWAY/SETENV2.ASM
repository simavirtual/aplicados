;*****************************************************************************
; PROGRAM ----: SETENV2.ASM 
; AUTHOR -----: Kevin E. Saffer, (904) 262-1020 Evenings EST
; COPYRIGHT --: None, placed into the public domain
; CREATED ----: 10/24/1992 at 23:54
; modified by MED 03/01/95 for CauseWay 386 DOS extender in protected mode
; lowercase opcodes are MED's, replaced source commented out with ';'
;*****************************************************************************
; This function is used to add variables to the DOS master environment table 
; for program-to-batch file communication.  It operates in the opposite manner
; as the Clipper GETE() function.  Only simple character strings are supported
; and no attempt has been made to allow binary data storage.
;
; Compile to an .OBJ using MASM, and link the resulting .OBJ into your Clipper
; application.  
;*****************************************************************************
; Syntax:  m_result = SETE(<set statement>)
;
;  Where:  m_result - result code, 0 = sucessful
;                                  1 = processing error
;                                  2 = no romm in environment
;          set statement - parameters to the DOS set command in uppercase,
;                          with no spaces between the equals sign.
;
; Code Fragment:
; m_result = SETE("MENUFILE=C:\TEMP.BAT")
; IF m_result <> 0
;   ? "An error occerred.""
; ENDIF
;*****************************************************************************

.RADIX 16               ;all values in hex
PUBLIC	SETE   	        ;declare callable functions public

EXTRN   __PARC:FAR	;get CHARACTER string, segment:offset in DX:AX
EXTRN   __RETNI:FAR	;return integer, push 1 register onto stack

DATASEG	SEGMENT BYTE 'DATA'
        STRSEG  DW      0       ;storage for segment of passed string
        STROFF  DW      0       ;storage for offset of passed string
        ENVSEG  DW      0       ;storage for command.com environment segment
        ENVLEN  DW      0       ;storage for length of the environment
DATASEG	ENDS

PROGSEG SEGMENT BYTE 'CODE'
.386P
        ASSUME  CS:PROGSEG,GS:DATASEG

SETE   	PROC    FAR	
        PUSH    BP              ;save needed registers         
        MOV     BP,SP
		push	gs
        PUSH    BX
        PUSH    CX
        PUSH    ES
        PUSH    SI
        PUSH    DI
        PUSH    DS
	 	MOV	AX,1	        ;retrieve passed string      
        PUSH    AX      
        CALL    __PARC  
        ADD     SP,2    
		mov	bx,DATASEG
		mov	gs,bx
        MOV     gs:STRSEG,DX    ;save the string segment
        MOV     gs:STROFF,AX    ;save the string offset
        MOV     AH,62H          ;obtain the address of the current psp
        INT     21H             ;note that this is an undocumented DOS call
        MOV     ES,BX	; es -> valid selector first time through search loop

		mov	ax,0ff03h	; GetSel, allocate a new selector
		int	31h
		push	bx		; save scratch selector
        mov	gs:ENVSEG,bx	; save environment (scratch) selector
		mov	ecx,0ffffh	; preset byte granular limit
		xor	di,di		; force failure on first PSP match check

PSP_SEARCH_1:
        MOV     AX,WORD PTR ES:[16H]    ;psp of parent program
;        CMP     BX,AX                   ;is it same as current ?

		cmp	di,ax		; is parent PSP same as current ?

        JE      PSP_SEARCH_2            ;if so, it is the shell
;        MOV     ES,AX                   ;(normally command.com)
;        MOV     BX,AX

		mov	di,ax		; save next PSP value in downward chain

; convert real mode segment to selector value for ES
; bx -> scratch selector, ecx == limit
		movzx	edx,word ptr es:[16h]
		shl	edx,4			; segment to linear address
		mov	ax,0ff0ah		; SetSelDet32, set selector base and limit
		int	31h
		mov	es,bx			; es -> scratch selector

        JMP     PSP_SEARCH_1            ;if not, go on

PSP_SEARCH_2:
;        MOV     AX,WORD PTR ES:[2CH]    ;get segment of environment
;        MOV     gs:ENVSEG,AX            ;save environment segment
;        DEC     AX                      ;get segment of environment's
;        MOV     ES,AX                   ;memory control block (mcb)
;        MOV     AX,WORD PTR ES:[03H]    ;get length of environment block
;        MOV     CL,4
;        SHL     AX,CL                   ;convert para's to bytes
;        MOV     gs:ENVLEN,AX            ;save environment length

; temporarily make scratch selector -> MCB
; es -> scratch selector -> shell PSP, di == PSP segment value
; bx -> scratch selector, ecx == limit
		movzx	edx,WORD PTR es:[2ch]
		shl	edx,4			; edx == linear address
		push	edx			; save linear address of environment
		movzx	edx,di
		dec	edx				; drop down one para to MCB
		shl	edx,4			; edx == MCB linear address
		mov	ax,0ff0ah		; SetSelDet32, set selector base and limit
		int	31h
		mov	di,WORD PTR es:[3]	; get length of environment block in paras
		shl	di,4			; convert to bytes
		mov	gs:ENVLEN,di	; save environment length

; make scratch selector -> environment
		pop	edx				; edx == linear address of environment
		mov	ax,0ff0ah		; SetSelDet32, set selector base and limit
		int	31h

        MOV     AX,gs:ENVSEG            ;segment of environment to DS
        MOV     DS,AX
        XOR     DI,DI                   ;start at beginning of environment
        MOV     AX,gs:STRSEG            ;segment of new variable to ES
        MOV     ES,AX
        MOV     SI,gs:STROFF            ;offset of new variable to SI
        MOV     CX,gs:ENVLEN            ;environment length to CX
        XOR     AX,AX                   ;set sucess code to zero

VAR_SEARCH_1:
        MOV     BL,BYTE PTR ES:[SI]     ;get next char of variable into bl
        CMP     BYTE PTR DS:[DI],BL     ;match into the environment table?
        JE      VAR_SEARCH_3            ;yes, check for end of variable name

VAR_SEARCH_2:
        MOV     SI,gs:STROFF            ;reset search string
        INC     DI                      ;advance to next byte in environment
        CMP     DI,CX                   ;at end of the environment table?
        JE      VAR_ADD                 ;yes, exit
        MOV     DX,DI                   ;save current environment position
        JMP     VAR_SEARCH_1            ;continue scanning

VAR_SEARCH_3:
        CMP     BL,'='                  ;end of string (variable found?)
        JE      VAR_FOUND_1             ;yes, remove it from the table
        INC     SI                      ;advance to next byte in string
        INC     DI                      ;advance to next byte in environment
        JMP     VAR_SEARCH_1

VAR_FOUND_1:
        MOV     BL,BYTE PTR DS:[DI]     ;get next environment byte
        CMP     BL,0                    ;at end of current string?
        JE      VAR_DELETE_1            ;yes, remove it
        INC     DI                      ;advance to next byte in environment
        JMP     VAR_FOUND_1

VAR_DELETE_1:
        INC     DI                      ;move to next variable name in env
        MOV     SI,DX                   ;set old variable location as dest

VAR_DELETE_2:
        MOV     BL,BYTE PTR DS:[DI]     ;get next environment byte
        MOV     BYTE PTR DS:[SI],BL     ;store it in old location
        CMP     BL,0                    ;end of string?
        JNE     VAR_DELETE_3;           ;no, continue copying
        MOV     BL,BYTE PTR DS:[DI+1]   ;moved a null, check for end of variable list
        CMP     BL,0                    ;end of variable list?
        JNE     VAR_DELETE_3;           ;no, continue copying
        MOV     BYTE PTR DS:[SI+1],BL   ;store it in old location
        JMP     VAR_ADD                 ;add the new variable

VAR_DELETE_3:
        INC     SI                      ;advance both pointers
        INC     DI
        CMP     DI,CX                   ;have we processed entire environment?
        JNE     VAR_DELETE_2            ;no, continue moving

VAR_ADD:
        MOV     CX,gs:ENVLEN            ;environment length to CX
        MOV     AX,gs:ENVSEG            ;get environment segment again
        PUSH    CX                      ;save length of environment
        MOV     ES,AX                   ;environment segment of command.com
        MOV     AL,00H                  ;scan all strings in environment
        MOV     DI,00H                  ;for a null byte
        CLD

EOV_SEARCH:
        REPNE   SCASB                   ;search for null 
        JE      EOV_FOUND               ;found one, check for end of variable list
        MOV     AX,01H                  ;an error occured, exit with error code 1
        POP     CX                      ;restore the stack
        JMP     SETE_EXIT               ;return to clipper

EOV_FOUND:
        CMP     BYTE PTR ES:[DI],00H    ;if a double 00h, we are at the end
        JNE     EOV_SEARCH              ;else scan on
        POP     CX                      ;restore length of environment
        SUB     CX,DI                   ;calculate remaining length
        DEC     CX                      
        PUSH    CX                      ;save length of remaining space
        PUSH    ES                      ;save offset where to put
        PUSH    DI                      ;new variable
        MOV     AX,gs:STRSEG            ;segment of variable
        MOV     DI,gs:STROFF            ;offset of variable
        MOV     ES,AX
        PUSH    ES
        PUSH    DI                      ;save pointer to string
        XOR     AL,AL
        MOV     CX,0FFFFH
        REPNE   SCASB
        INC     CX                      ;get length of string
        NOT     CX                      ;into cx 
        POP     SI
        POP     DS                      ;get pointer to string
        POP     DI
        POP     ES                      ;get pointer into environment
        POP     AX                      ;get remaining length 
        CMP     AX,CX                   ;if not long enough
        MOV     AX,2                    ;return error code 2
        JLE     SETE_EXIT
        REP     MOVSB                   ;move string into
        XOR     AX,AX                   ;sucess code to AX
        STOSW                           ;add end of string marker

SETE_EXIT:

; release scratch selector
		pop	bx			; get selector to release in bx
		push	ax		; save critical register
		mov	ax,0ff04h	; RelSel, release a selector
		int	31h
		pop	ax			; restore critical register

        POP     DS       ;restore registers and clear direction flag
        POP     DI
        POP     SI
        POP     ES
        POP     CX
        POP     BX
		pop	gs
        POP     BP
        CLD

        PUSH    AX       ;result code is in AX
        CALL    __RETNI  ;return result code to clipper
        ADD     SP,2     ;add 2 to the stack for each register pushed
        RET   	         ;return to clipper

SETE    ENDP	         ;end the procedure
PROGSEG ENDS	         ;end the code segment
        END           	 ;end the program
