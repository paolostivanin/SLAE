#!/usr/bin/python2

#Author:		Paolo Stivanin <https://github.com/polslinux>
#Tested on:		Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID:		526

shellcode = ("")

encoded = ""
i=1
LEN=len(shellcode)
BYTE=

print 'Lenght of shellcode: %d' % len(bytearray(shellcode)) + ', encoded shellcode (nasm format):'
for x in bytearray(shellcode):
	y = x^BYTE
	encoded += '0x'
	if i < LEN:
		encoded += '%02x,' % y
	else:
		encoded += '%02x' % y
	i += 1
	
print encoded
