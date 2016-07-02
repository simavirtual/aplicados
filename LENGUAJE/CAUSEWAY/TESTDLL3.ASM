.model large
.data
indata1	DB	13,10,"Entering version 2 DLL...",13,10
indata2	DB	"Exiting version 2 DLL...",13,10
tpdata	DB	"Hello from TWOPROC v.2!",13,10
opdata	DB	"Hello from ONEPROC v.2!",13,10
padata	DB	" is the hexadecimal value",13,10
ScratchBuffer	DB	8 DUP (0)
.code
.386

INIT	PROC	FAR
	push	ds
	mov	dx,_DATA
	mov	ds,dx
	cmp	eax,0		; see if entry condition
	jne	interm		; no, termination

	mov	dx,OFFSET indata1
	mov	cx,29
	mov	bx,1
	mov	ah,40h
	int	21h
	jmp	inret

interm:
	mov	dx,OFFSET indata2
	mov	cx,26
	mov	bx,1
	mov	ah,40h
	int	21h

inret:
	xor	eax,eax	; flag no initialization errors
	pop	ds
	retf
INIT	ENDP

ONEPROC	PROC FAR EXPORT
	push	ds
	push	esi
	mov	esi,eax		; save passed parameter
	mov	ax,_DATA
	mov	ds,ax
	mov	es,ax
	mov	dx,OFFSET opdata
	mov	cx,25
	mov	bx,1
	mov	ah,40h
	int	21h

	mov	di,OFFSET ScratchBuffer
	mov	edx,esi
	call	DwordtoAsciiHex
	mov	dx,OFFSET ScratchBuffer
	mov	cx,8
	mov	bx,1
	mov	ah,40h
	int	21h

	mov	dx,OFFSET padata
	mov	cx,27
	mov	bx,1
	mov	ah,40h
	int	21h
	pop	esi
	pop	ds
	retf
ONEPROC	ENDP

TWOPROC	PROC FAR EXPORT
	push	ds
	mov	ax,_DATA
	mov	ds,ax
	mov	dx,OFFSET tpdata
	mov	cx,25
	mov	bx,1
	mov	ah,40h
	int	21h
	pop	ds
	retf
TWOPROC	ENDP

;*****************************
;* DWORDTOASCIIHEX           *
;*****************************

; convert dword in edx to ascii hex, place in es:di -> buffer
; updates di
; destroys al,cx,edx

DwordToAsciiHex	PROC
	mov	cx,8			; 8 printable chars per dword

dtaloop:
	rol	edx,4			; get next char value (4 MSB)
	mov	al,dl
	and	al,0fh			; mask off extraneous bits
	cmp	al,0ah			; see if more than single digit decimal
	jb	dta2
	add	al,7			; convert to alphabet hex

dta2:
	add	al,30h			; convert to ASCII
	stosb				; save it to buffer
	loop	dtaloop
	ret
DwordToAsciiHex	ENDP

END	INIT
