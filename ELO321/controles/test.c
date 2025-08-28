#include <stdio.h>
#include <stdlib.h>   
#include <unistd.h>   
#include <sys/wait.h>
#include <sys/types.h>
#include <fcntl.h>    
//retorna el PID del proceso hijo.

int main() {
    pid_t pid;
    const char *myfile = "archivo_creado_por_hijo.txt";
    pid = fork();
    if (pid < 0) { exit(1); } 
    if (pid == 0) {
        printf("PID: %d\n", getpid());
        int fd = open(myfile, O_WRONLY | O_CREAT | O_TRUNC, 1777);
        if (fd == -1) {exit(1);}
        close(fd);
        exit(0);
    }else {
        //printf("Parent PID: %d\n",getppid());
	}
    return 0;
}