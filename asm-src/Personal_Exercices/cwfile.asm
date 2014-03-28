;Description: 	Create file and write a string inside it
;Author: 	Paolo Stivanin <https://github.com/polslinux>
;SLAE ID: 	526 

global _start

section .text

_start:

	mov eax, 0x5 ;syscall int open(const char *pathname, int flags, mode_t mode)
	mov ebx, filename ;first arg of open function
	mov ecx, 0102o ;O_CREAT mode (/usr/include/asm-generic/fcntl.h) which is in *octal* (0100) and i have to add 2 for read-write so 0102o
	mov edx, 0644o ;file permission 0644 (again, it's *octal*)
	int 0x80 ;interrupt
	mov ebx, eax ;eax has the return value of open function (the file descriptor) so i have to put it into ebx (first arg of write func)
	mov eax, 4 ;syscall ssize_t write(int fd, const void *buf, size_t count)
	mov ecx, message ;second arg of write func
	mov edx, mlen ;third arg of write func
	int 0x80
	mov eax, 6 ;close
	int 0x80

	mov eax, 0x1 ;syscall _exit(int status)
	mov ebx, 0x0 ;return 0 
	int 0x80 ;interrupt

section .data
	filename: db "file.txt",0 ;the filename *must* be null-terminated
	message: db "This is a string written to a file",0x0a
	mlen: equ $-message

