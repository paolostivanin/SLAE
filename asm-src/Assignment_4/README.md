Assignment #4: Custom Encoding Schema
=====================================

Instructions:
-------------
* Create a custom encoding schema like "insertion encoder"
* PoC using execve-stack as the shellcode to encode, decode and run with the created schema

PoC:
----
1. The execve /bin/sh shellcode will be encoded using XOR
2. The encoded shellcode will be encoded againg using the Insertion Encoder (with an auto incrementing value)
3. Every 32 bits the result will be left-rotated of 16 bits: `ROL16b_EVERY_32b(INSERTION(XOR(shellcode)))`
