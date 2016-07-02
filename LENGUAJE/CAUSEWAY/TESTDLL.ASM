.model large
.data
indata1	DB	13,10,"Entering DLL...",13,10
indata2	DB	"Exiting DLL...",13,10
tpdata	DB	"Hello from TWOPROC!",13,10
opdata	DB	"Hello from ONEPROC!",13,10
padata	DB	" is the decimal value",13,10
ScratchBuffer	DB	12 DUP (0)
.code
.386

INIT	PROC	FAR
	push	ds
	mov	dx,_DATA
	mov	ds,dx
	cmp	eax,0		; see if entry condition
	jne	interm		; no, termination

	mov	dx,OFFSET indata1
	mov	cx,19
	mov	bx,1
	mov	ah,40h
	int	21h
	jmp	inret

interm:
	mov	dx,OFFSET indata2
	mov	cx,16
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
	mov	dx,OFFSET opdata
	mov	cx,21
	mov	bx,1
	mov	ah,40h
	int	21h

	mov	eax,esi
	call	DisplayNumber
	mov	dx,OFFSET padata
	mov	cx,23
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
	mov	cx,21
	mov	bx,1
	mov	ah,40h
	int	21h
	pop	ds
	retf
TWOPROC	ENDP

;***************
; DISPLAYNUMBER
;***************
; display number in decimal
; upon entry eax == number to display
; destroys eax,ebx,ecx,edx

DisplayNumber	PROC	NEAR
	mov	ecx,OFFSET DGROUP:ScratchBuffer+11
	mov	ebx,10		; use as constant

dnloop:
	xor	edx,edx		; value in edx:eax
	div	ebx			; get decimal digit
	or	dl,30h		; convert to ASCII
	mov	ds:[ecx],dl
	test	eax,eax	; see if any digits left
	je	dn2			; no
	dec	ecx			; back up buffer one position
	jmp	dnloop

; ecx -> print position of number
dn2:
	mov	edx,ecx
	mov	eax,OFFSET DGROUP:ScratchBuffer+11
	sub	eax,ecx
	inc	eax			; compute count of characters in number
	mov	ecx,eax
	mov	bx,1
	mov	ah,40h		; write to file or device
	int	21h
	ret
DisplayNumber	ENDP

END	INIT
