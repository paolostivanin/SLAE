/* Descr:	Template for running egghunter
 * Author:	Paolo Stivanin <https://github.com/polslinux>
 * SLAE ID:	526
 */

#include <stdio.h>
#include <string.h>

unsigned char eggshell[] = \
"";

unsigned char shellcode[] = \
""; //egg
""; //egg
""; //shellcode

int main(void){
	printf("EggHunter: %zu\n", strlen(eggshell));
	printf("Shellcode: %zu\n", strlen(shellcode));
	int (*ret)() = (int(*)())eggshell;
	ret();
	return 0;
}
