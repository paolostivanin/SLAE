#!/usr/bin/python2

#Author:		Paolo Stivanin <https://github.com/polslinux>
#Tested on:		Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID:		526

shellcode = ("")

encoded = ""
i=1
LEN=len(bytearray(shellcode))
BYTE=

print 'Lenght of shellcode: %d' % len(bytearray(shellcode)) + ', encoded shellcode (nasm format):'
for x in bytearray(shellcode) :
    encoded += '0x'
    encoded += '%02x,' % x
    if i < LEN:
    	encoded += '0x%02x,' % BYTE
    else:
    	encoded += '0x%02x' % BYTE
    i+=1

print encoded
