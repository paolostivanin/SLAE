#!/bin/bash

#Description:	Assignment #3 (EggHunter Demo, configure payload)
#Author: 		Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:		526

if [ -z "$1" || -z "$2" ]; then
	echo "Usage: $0 <elf-file> <source-file>"
	exit -1
fi


echo "[+] Updating $1 elf..."

echo "[+] Updating $2 source..."

echo "[+] All done :)"