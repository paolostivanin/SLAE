#!/bin/bash

#Author:        Paolo Stivanin <https://github.com/polslinux>
#Tested on:     Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID: 	526

if [ -z "$1" ];then
	echo "Usage: $0 filename"
	exit -1
fi

echo "[+] Getting shellcode with objdump..."

for i in $(objdump -d $1 |grep "^ " |cut -f2); do echo -n '\x'$i; done; echo

echo "[+] Done!"
