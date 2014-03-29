/*
 * Author:		Paolo Stivanin <https://github.com/polslinux>
 * Description:	Encode a shellcode using XOR
 * Tested on:	Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
 * SLAE ID:		526
 * 
 */

#include <stdio.h>
#include <stdint.h>

/* Inside the array sc[] you have to put the result of the following cmd:
 * echo SHELLCODE-FORMAT-OBJDUMP |sed 's/x//g'| sed 's/\(..\)/0x\1,/g'
 */

#define LEN  //this is the lenght of the shellcode

int main(void){
	int i;
	uint8_t encByte = {0xAA}; //this is the byte using to encode the shellcode
	int sc[] = {};
	int encoded_sc[LEN];
	
	for(i=0;i<LEN;i++){
		encoded_sc[i] = sc[i]^encByte;
	}

	for(i=0; i<LEN; i++){
		if(i == LEN-1) printf("0x%02x", encoded_sc[i]);
		else printf("0x%02x,", encoded_sc[i]);
	}
	printf("\n");

	return 0;
}
