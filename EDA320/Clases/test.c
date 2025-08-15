#include <stdio.h>
#include <stdlib.h>

int main(){
    int a = 5;

    {   
        for(int i = 0 ; i<5 ; i++){
            a += i;
            printf("%d\n",a);
        }
    }

    printf("Numero: %d\nTester: %d",a,21);

    return 0;
}