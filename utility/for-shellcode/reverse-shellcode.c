/* Reverse an input shellcode
 * Author: Paolo Stivanin <https://github.com/polslinux>
 * SLAE Student ID: 526
 */

#include <stdio.h>
#include <stdint.h>

int main(void){
	uint8_t shellcode[] = {}; //shellcode in this format: 0x33,0x4f,0x5c,etc
	int i, j=0;
	size_t len = sizeof(shellcode);
	uint8_t t[len];
	
	for(i=len-1; i>=0; i--){
		t[j] = s[i];
		j++;
	}
	
	printf("Reversed shellcode:\n");
	for(i=0; i<len; i++){
		printf("%02x ", t[i]);
	}
	printf("\n");
	
	return 0;
}
