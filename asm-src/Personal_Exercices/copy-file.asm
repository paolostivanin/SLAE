;Description: 	Copy file (max size 65535)
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

global _start
section .text
_start:
	mov eax,0x5	;syscall open
	mov ebx,input	;input file
	xor ecx,ecx	;readonly (0000o)
	int 0x80

	mov ebx,eax	;file descriptor
	mov eax,0x3	;syscall read
	mov ecx,buf	;where put read bytes
	mov edx,0xffff	;read up to 65535 bytes
	int 0x80

	mov edi,eax	;read bytes (read syscall return the read bytes inside the eax register)
	mov eax,0x6	;syscall close (fd is already inside the ebx register)
	int 0x80

	mov eax,0x5	;syscall open
	mov ebx,output	;output file
	mov ecx,0102o	;mode (O_RDWR|O_CREAT)
	mov edx,0644o	;permission
	int 0x80

	mov ebx,eax	;file where to write
	mov eax,0x4	;syscall write
	mov ecx,buf	;where are the bytes to write
	mov edx,edi	;how many bytes to write
	int 0x80

	mov eax,0x6	;syscall close (fd is already inside the ebx register)
	int 0x80

	mov eax,0x1	;syscall exit
	mov ebx,0x5	;retcode
	int 0x80

section .data
	input db "/etc/passwd",0x0
	output db "/tmp/outfile",0x0

section .bss
	buf resb 65535
