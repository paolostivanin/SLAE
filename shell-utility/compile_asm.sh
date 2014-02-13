#!/bin/bash

#Author:        Paolo Stivanin <https://github.com/polslinux>
#Tested on:     Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID: 	526

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

echo "[+] Done :)"
