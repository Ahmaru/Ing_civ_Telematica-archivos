#include <stdio.h>

int main(){

    long int n,conteo = 0,guardar = 0,i=0;

    printf("NUMERO: "); //17493
    scanf("%ld",&n);

    //parista o imparista
    do{
        guardar = n%10;
        if(guardar%2 == 0){
            conteo++;
            guardar = 0;
        }else {
            guardar = 0;
        }
        n = n/10;
        i++;

    }while (n != 0);

    if(i==conteo){
        printf("parista\n");
    }else if (i != conteo ){
        printf("imparista\n");
    }

    return 0;
}

