;Description: 	How to print a string which isn't a multiple of 4 byte
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

global _start

section .text
_start:

	;syscall
	mov al,0x4

	;fd
	mov bl,0x1

	;pushing null bytes to the stack (because the string must be null-terminated)
	xor edx,edx
	push edx

	;buf in reverse order
	push 0x0a6f6c6c ;(\noll)
	push WORD 0x6568;(eh)
	
	;moving on ecx the top of the stack
	mov ecx,esp
	mov dl,6
	int 0x80

	;exit
	mov al,0x1
	mov bl,0x5
	int 0x80
