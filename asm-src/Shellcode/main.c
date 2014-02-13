/* Template for running shellcode
 * Author: Paolo Stivanin <https://github.com/polslinux>
 * SLAE Student ID: 526
 */

#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = \
"";

int main(void){
	printf("%zu\n", strlen(shellcode));
	int (*ret)() = (int(*)())shellcode;
	ret();
	return 0;
}
