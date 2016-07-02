.386

;*****************************
;* Public declarations       *
;*****************************

PUBLIC	GetEnv

;*****************************
;* External data             *
;*****************************

EXTRN	__retc:FAR
EXTRN	__parclen:FAR
EXTRN	__parc:FAR

GETE_TEXT	SEGMENT WORD PUBLIC USE16 'CODE'

ASSUME CS:GETE_TEXT

;*****************************
;* SEARCHEVARDIRECTORY       *
;*****************************

; search environment variable directories for setting
; this version is independent of any environment variable length,
; (i.e. doesn't crash with PATH > 127 chars, etc.)
; somewhat ugly code, but it works and only a few bytes long anyway
; destroys ax,bx,cx,dx,es,gs

GetEnv	PROC	FAR
	push	si			; save critical registers
	push	di

; get length of first passed parameter
	push	1
	call	__parclen
	add	sp,2
	or	ax,ax
	je	sevfail			; zero length
	push	ax			; save length

; get protected mode PSP of program
	mov	ah,62h			; get PSP
	int	21h
	push	bx			; save PSP

; get first parameter string in dx:ax
	push	1
	call	__parc
	add	sp,2

	mov	gs,dx
	mov	bx,ax
	pop	es				; es -> PSP
	pop	cx				; cx == length

; see if environment variable is present
	xor	si,si
	mov	es,es:[2ch]		; es:si -> environment block strings

sevscan:
	xor	di,di			; offset into target string to match

matchloop:
	lods	BYTE PTR es:[0]	; get byte from environment string
	cmp	al,gs:[bx+di]	; see if matches target
	je	bytematch		; yes
	or	al,es:[si]		; two zero values in a row mean end of environment
	jne	sevscan			; no target match, more chars left
	jmp	SHORT sevfail	; end of environment, no match, search failed

; check that environment string match is not part of another environment string
bytematch:
	or	di,di			; di is zero if matching first char
	jne	sevnext			; not matching first char
	cmp	si,1			; si==1 if first string in environment block
	je	sevnext			; first string, not a part of another string by definition
	cmp	BYTE PTR es:[si-2],0	; char before environment string in block must be nonzero
	jne	sevscan			; nonzero, subset of another string, keep scanning for match

sevnext:
	inc	di				; match, move to next byte of target
	cmp	di,cx			; check if all bytes matched
	jb	matchloop		; not yet
	cmp	BYTE PTR es:[si],'='	; see if end of environment string
	jne	sevscan			; no

sevsuccess:
	mov	dx,es
	mov	ax,si
	inc	ax				; adjust for equals sign

sevret:
	push	dx
	push	ax
	call	__retc
	add	sp,4			; get return value off of stack
	pop	di				; restore critical registers
	pop	si
	retf

sevfail:
	xor	ax,ax
	mov	dx,ax
	jmp	SHORT sevret

GetEnv	ENDP

ENDS

END
