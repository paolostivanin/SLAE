Assignment #6, Polymorphic Shellcode
====================================

Instructions:
-------------
* Take up 3 shellcodes from shell-storm and create polymorphic versions of them
* The polymorphic version *cannot* be larger than 150% of existing one
* Bonus point for making it shorter than original

Shellcode 1
-----------
Link:				http://shell-storm.org/shellcode/files/shellcode-590.php
Description:		chmod("/etc/shadow", 0777)
Original length:	33 bytes
Mine length:		49 bytes (+48,5% than the original)

Shellcode 2:
------------
Link:				http://shell-storm.org/shellcode/files/shellcode-622.php
Description:		sys_sethostname("PWNED!", 6)
Original length:	32 bytes
Mine length:		27 bytes (-15,6% than the original)

Shellcode 3:
------------
Link:				http://shell-storm.org/shellcode/files/shellcode-848.php
Description:		Set /proc/sys/net/ipv4/ip_forward to 0 and exit() 
Original length:	83 bytes
Mine length:		107 bytes (+28,9% than the original)
