#!/usr/bin/python2

#Author:		Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:		526

import socket

dotIP = ""

print 'Original IP:'
print dotIP , '\n'

print 'Hex IP:'
hip = socket.inet_aton(dotIP)
print hip.encode('hex') , '\n'

print 'Reversed hex IP:'
print hip[::-1].encode('hex')
