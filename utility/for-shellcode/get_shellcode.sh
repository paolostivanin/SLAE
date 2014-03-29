#!/bin/bash

#Author:	Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:	526

if [ -z "$1" ];then
	echo "Usage: $0 filename"
	exit -1
fi

echo "[+] Shellcode:"

for i in $(objdump -d $1 |grep "^ " |cut -f2); do echo -n '\x'$i; done; echo
