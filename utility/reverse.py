#!/usr/bin/python2

#Author:		Paolo Stivanin <https://github.com/polslinux>
#Tested on:		Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
#SLAE ID:		526

def split(str, num):
    return [ str[start:start+num] for start in range(0, len(str), num) ]


toRev = ""
revd = toRev[::-1]
encoded = revd.encode('hex')

print 'Length of original string is: %d' % len(toRev)

print 'Original string:'
print toRev , '\n'

print 'Reversed string:'
print revd , '\n'

print 'Splitted encoded string:'
print split(encoded, 8)
