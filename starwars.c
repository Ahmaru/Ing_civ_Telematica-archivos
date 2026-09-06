#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <signal.h>

int son_pid;

void recibe_signal(int sig){
    printf("Vader> Oye Luke, yo soy tu Padre.......\n");
    kill(son_pid,SIGUSR1);
}

int main() {

    pid_t prcs = fork();

    if(prcs == 0){
        printf("Ola soy hijo %d\n",getpid());
        son_pid = getpid();
        signal(SIGUSR2,SIG_DFL);

        while(1){
            pause();
        }
    }else if (prcs > 0) {
        printf("Soy padre....%d\n",getpid());
        recibe_signal(SIGUSR2);
    }

    return(0)
}
