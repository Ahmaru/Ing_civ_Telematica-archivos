#include <stdio.h>
#include <stdlib.h>

void EsPalindromo(char* palabra,int n,char* palabrados,int *v);
char* DarVuelta(char* uno,int c);

int main(){

    char P[25];
    int count = 0;
    int verificador = 0;

    printf("Ingrese palabra a determinar: ");
    scanf("%s",P);

    for(int i = 0 ; P[i] != '\0' ; i++){
        count++;
    }

    char *Prime = DarVuelta(P,count);

    EsPalindromo(P,count,Prime,&verificador);

    if(verificador == count){
        printf("Es palindromo.\n");
    }else if(verificador != count){
        printf("No.\n");
    }

    free(Prime);
    return 0;
}

void EsPalindromo(char* palabra , int n, char* palabrados, int *v){
    for(int i = 0 ; i < n ; i++){
        if(palabra[i] == palabrados[i]){
            (*v)++;
        }
    }
}

char* DarVuelta(char* uno , int c){

    char* nuevo = malloc(sizeof(char)*(c+1));

    for ( int i = 0 ; i < c+1 ; i++){
        nuevo[i] = uno[c-i-1];
    }

    return nuevo;
}
