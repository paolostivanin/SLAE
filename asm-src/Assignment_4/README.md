Assignment #4: Custom Encoding Schema
=====================================

Instructions:
-------------
* create a custom encoding schema like "insertion encoder"
* PoC using execve-stack as the shellcode to encode, decode and run with the created schema

PoC:
----
1. The original shellcode will be reversed;
2. The reversed shellcode will be splitted in first_half and second_half;
3. The final encoded shellcode will be: `INSERTION(VALUE,XOR([second_half][first_half]))`
