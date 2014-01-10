#!/bin/bash

#Filename:	compile_asm.sh
#Author:	Paolo Stivanin <www.paolostivanin.com>
#Date:		2013 December
#Location:	Veneto (Italy)
#Desc:		Assembling with NASM and ld
#Tested on:	Ubuntu 12.04/13.10 x86 and amd64

tmp=$(basename "$1")
fl="${tmp%.*}"
echo $fl

echo "--> Assembling with NASM..."
nasm -f elf32 -o "$fl.o" "$1"

echo "--> Linking..."
if [ $(uname -m) == "x86_64" ]; then
	ld  -m elf_i386 -o $fl $fl.o
else
	ld -o $fl $fl.o
fi

echo "--> Done"
