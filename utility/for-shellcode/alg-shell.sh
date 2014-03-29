#!/bin/bash

#Author:	Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:	526

if [ -z "$1" ];then
	echo "Usage: $0 filename"
	exit -1
fi

FILE_NO_EXT="${1%.*}"

echo "[+] Assembling with NASM..."
nasm -f elf32 -o "${FILE_NO_EXT}.o" "$1"

echo "[+] Linking..."
if [ $(uname -m) == "x86_64" ]; then
	ld  -m elf_i386 -o ${FILE_NO_EXT} ${FILE_NO_EXT}.o
else
	ld -o ${FILE_NO_EXT} ${FILE_NO_EXT}.o
fi

echo "[+] Shellcode:"
for i in $(objdump -d ${FILE_NO_EXT} |grep "^ " |cut -f2); do echo -n '\x'$i; done; echo
