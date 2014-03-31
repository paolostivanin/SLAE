Assignment #3: EggHunter:
=========================

Instructions:
-------------
* Study about egghunter
* Make a working demo
* Make it configurable for different payload

PoC:
----

```
_start:
	jmp short stack

getStack:
	pop eax

ll:	cmp eax,egg
	cmp eax+4,egg
	jne la
	jmp eax

la:	inc eax
	jmp ll

stack:
	call getStack
```