;Description: 	How to print a string which isn't a multiple of 4 byte
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

global _start

section .text
_start:

	;syscall
	xor eax,eax
	mov al,0x4

	;fd
	xor ebx,ebx
	mov bl,0x1

	;pushing null bytes to the stack (because the string must be null-terminated)
	xor edx,edx
	push edx

	;buf in reverse order
	push 0x0a6f6c6c ;(\noll)
	;if i have 2 bytes i can push them on the stack using WORD
	;mov dx,0x6568 (eh)
	;push WORD dx
	
	;otherwise if i have only 1 byte to push (65) i have to add garbage bytes (69)...
	push 0x65696969 ;(eiii)
	;...and then moving the stack pointer forward (in this case +3 because i have 3 garbage bytes)
	add esp,3
	
	;moving on ecx the top of the stack
	mov ecx,esp
	xor edx,edx
	mov dl,5
	int 0x80

	;exit
	xor eax,eax
	mov al,0x1
	xor ebx,ebx
	mov bl,0x5
	int 0x80
