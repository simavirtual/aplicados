; CWPLOCK linkable routine for CA-Clipper
;
; CWPLOCK will lock in memory all code and data of a loaded executable,
; that is, everything except the stack and memory dynamically allocated
; by Clipper's or third party routines.  To use CWPLOCK, link CWPLOCK.OBJ
; and call it in your application via the line:
; 
; cwplock()
; 
; preferably at the beginning of your program's execution.
; 
; Why would one want to use CWPLOCK?
; 
; Calling this routine allows most the debugging advantages of SET
; CAUSEWAY=NOVM, with fewer of the drawbacks.  By locking memory, you
; avoid the not terribly rare problem of third parties (and CA in CA
; Tools) not locking their hardware interrupt handlers, subsequently
; crashing an application when virtual memory kicks in.  However, unlike
; NOVM, virtual memory may still be used by the application with this
; routine linked and called.  The problematic parts that possibly exist
; therein are properly locked even if the original routines did not do it
; themselves.
; 
; When would and when wouldn't you use this routine?
; 
; Do not use CWPLOCK if your application is not running under DOS.
; Windows and OS/2 handle virtual memory more gracefully, so that locking
; hardware interrupt handlers is not an issue.  Do not use this routine
; if you are not having any problems; it is unnecessary and
; counterproductive.  Do not use this routine if your physical memory is
; smaller or only a couple hundred K larger than the EXE size
; (uncompressed). DO try using this routine if you are having any
; unexplained problems with an application running under DOS.
; 
; Remember, locked memory is unswappable memory, directly subtracting
; what CauseWay uses in conjunction with virtual memory.  Whatever you
; lock, CauseWay cannot use except to hold the original code and data.
; If after locking all this memory your machine only has 100K or a
; similar miniscule amount of unlocked physical memory, your application
; will perform poorly, as virtual memory thrashes around in the little
; bit of physical memory left to it.
; 
; On the other hand, calling CWPLOCK is a great way to quickly tell if
; your application is having problems due to an unlocked interrupt
; handler.  If your problem goes away when calling CWPLOCK, there is an
; excellent chance that an unlocked handler is causing grief.  And if
; your (free physical memory - EXE size) >= 1M, you usually will not see
; noticeable performance difference by locking your application image in
; memory and can probably continue to use it without complaint.

PUBLIC	cwplock

STACK	SEGMENT PARA STACK 'STACK'
STACK	ENDS

CWCODE	SEGMENT PARA PUBLIC 'CODE'
assume	cs:CWCODE
.386P

cwplock:
	pusha
	mov	ax,0ff00h	; Info
	int	31h
	mov	bx,STACK

cwploop:
	sub	bx,8		; standard selector [de]increment
	jc	cwpret
	verr	bx
	jnz	cwpret		; not a readable segment
	movzx	ebx,bx
	lsl	eax,ebx
	jnz	cwpret		; not an application segment
	test	eax,eax
	je	cwploop		; zero length segment
	mov	ax,0ff08h	; GetSelDet32
	int	31h			; edx==linear base, ecx==byte granular limit
	jc	cwpret		; failure

	cmp	edx,100000h
	jb	cwploop		; low memory, automatically locked
	inc	ecx			; change limit to byte count in ecx
	mov	esi,edx		; linear address to lock
	mov	ax,0ff1ch	; LockMem32
	int	31h
	jc	cwpret		; failure
	jmp	cwploop

cwpret:
	popa
	retf
CWCODE	ENDS
END
