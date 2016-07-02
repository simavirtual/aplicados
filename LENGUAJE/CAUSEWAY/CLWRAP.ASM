.model medium
EXTRN	__parnl:FAR
EXTRN	ONEPROC:FAR
EXTRN	TWOPROC:FAR
EXTRN	THREEPROC:FAR,FOURPROC:FAR
PUBLIC	DLL_TEST
.code
.386
DLL_TEST	PROC	FAR
	mov	ax,1
	push	ax
	call	__parnl
	add	sp,2
	push	dx
	push	ax
	pop	eax
	call	ONEPROC
	call	TWOPROC
	call	THREEPROC
	call	FOURPROC
	ret
DLL_TEST	ENDP
end
