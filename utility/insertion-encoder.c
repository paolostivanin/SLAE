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

#define LEN 25 //this is the lenght of the shellcode

int main(void){
	int i, j=0;
	uint8_t insertByte = {0xAA}; //this is the byte using to encode the shellcode
	int sc[] = {};
	int encoded_sc[LEN*2];
	
	for(i=0; i<LEN*2; i++){
		encoded_sc[i] = sc[j];
		encoded_sc[i+1] = insertByte;
		i++;
		j++;
	}

	for(i=0; i<LEN*2; i++){
		if(i==(LEN*2)-1) printf("0x%02x", encoded_sc[i]);
		else printf("0x%02x,", encoded_sc[i]);
	}
	printf("\n");

	return 0;
}
