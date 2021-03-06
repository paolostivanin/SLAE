#!/bin/bash

#Description:	Assignment #1 (Shell_Bind_TCP, configure port)
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