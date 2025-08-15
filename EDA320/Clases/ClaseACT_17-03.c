#include <stdio.h>
#include <stdlib.h>

int main(){

    int n;

    printf("Ingrese numero: \n");
    scanf("%d",&n);

    //Buscar expresion para numero primo

    int noEsPrimo[n-1];

    printf("%d\n",n);

    for(int i = 2 ; i<n ; i++){
        for(int j = 2 ; (i*j) <n ; j++){
            //if( noEsPrimo[i*j] == 1) break;
            noEsPrimo[(i*j)] = 1;
        }
    }

    //printf("OLA \n");

    if (noEsPrimo[n] == 0){

        printf("Es primo.\n");

    } else {
        printf("Es compuesto. \n");

    }

    //printf("OLA\n");

    return 0;
}
