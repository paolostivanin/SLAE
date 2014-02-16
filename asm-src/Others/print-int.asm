;Description: 	Print an integer
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

;nasm -f elf32 print.int.asm && gcc -o print-int print-int.o

extern printf
extern exit

global main
section .text
main:
	push val
	call printf
	add esp,0x4

	mov eax,0xa
	call exit
	
section .data
	val db "84",0xa,0x0
