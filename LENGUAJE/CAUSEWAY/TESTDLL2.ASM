.model large
.data
indata1	DB	"Entering another DLL...",13,10
indata2	DB	"Exiting another DLL...",13,10
tpdata	DB	"Hello from THREEPROC!",13,10
fdpata	DB	"Hello from FOURPROC!",13,10
.code
.386

INIT	PROC	FAR
	push	ds
	mov	dx,_DATA
	mov	ds,dx
	cmp	eax,0		; see if entry condition
	jne	interm		; no, termination

	mov	dx,OFFSET indata1
	mov	cx,25
	mov	bx,1
	mov	ah,40h
	int	21h
	jmp	inret

interm:
	mov	dx,OFFSET indata2
	mov	cx,24
	mov	bx,1
	mov	ah,40h
	int	21h

inret:
	xor	eax,eax	; flag no initialization errors
	pop	ds
	retf
INIT	ENDP

FOURPROC	PROC FAR EXPORT
	push	ds
	mov	ax,_DATA
	mov	ds,ax
	mov	dx,OFFSET fdpata
	mov	cx,22
	mov	bx,1
	mov	ah,40h
	int	21h
	pop	ds
	retf
FOURPROC	ENDP

THREEPROC	PROC FAR EXPORT
	push	ds
	mov	ax,_DATA
	mov	ds,ax
	mov	dx,OFFSET tpdata
	mov	cx,23
	mov	bx,1
	mov	ah,40h
	int	21h
	pop	ds
	retf
THREEPROC	ENDP

END	INIT
