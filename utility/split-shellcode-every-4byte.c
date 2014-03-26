/*
 * Author:		Paolo Stivanin <https://github.com/polslinux>
 * Description:	Reverse shellcode every 4 byte (needed for encoded-spawn-bash.asm)
 * Tested on:	Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
 * SLAE ID:		526
 * 
 */

#include <stdio.h>
#include <string.h>

/* Shellcode MUST be in this format:
 * eb285e31c9b108
 * 
 * and NOT in one of these format:
 * \xeb\x28\x5e\x31\xc9\xb1\x08
 * 0xeb,0x28,0x5e,0x31,0xc9,0x08
 */

static void split_every_four(const char *, size_t);

int main(int argc, char **argv){
	if(argc != 2){
		printf("Usage: %s <shellcode>\n", argv[0]);
		return -1;
	}
	const char *reversed_shellcode = argv[1];
	size_t len = strlen(reversed_shellcode);
	if((len % 2) != 0){
		printf("Shellcode length MUST be a multiple of 2\n");
		return -1;
	}
	split_every_four(reversed_shellcode, len);
	return 0;
}

static void split_every_four(const char *str, size_t LEN_STR){
	char dest[LEN_STR+1];
	int i, j=0, start_offset;
	
	if(LEN_STR >= 8) start_offset = 6; //if the length of the shellcode is greater than 8 read start from byte 6 (so reading 7,8)
	else start_offset = LEN_STR-2; //else read start from the length-2 (so if length is 7 read start from 5 (so reading 6,7))
	
	int end_offset = 0;
	
	while(start_offset < (int)LEN_STR+1){
		for(i=start_offset; i>=end_offset; i--){
			memcpy(dest+j, str+i, 2);
			i -= 1;
			j += 2;
		}
		if((LEN_STR-8) >= 8) start_offset += 8;
		else{
			if((LEN_STR-8) <= 0) break; //if shellcode length is lesser than 8 we have finished
			else start_offset += LEN_STR-8; //else we start read from the remaining bytes
			}
		
		end_offset += 8;
	}
	dest[LEN_STR] = '\0';
	printf("%s\n", dest);
}
