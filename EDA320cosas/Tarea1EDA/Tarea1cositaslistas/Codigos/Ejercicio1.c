#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* sumaStrings(char *num1 , char *num2); char * ordenar(char num[]);


int main(){

    char num1static[100000];
    char num2static[100000];

    printf("Ingrese primer numero a sumar: \n");
    scanf("%s", num1static);

    printf("Ingrese segundo numero a sumar: \n");
    scanf("%s",num2static);

    char *resultado = sumaStrings(num1static,num2static);

    printf("La suma es: %s\n",resultado);

    free(resultado);
    
    return 0;

}

// esta funcion ordena el numero del digito mas pequeño al más grande
char * ordenar(char num[]){

    long int lon = strlen(num);

    char *usarorden = (char *)malloc((lon + 1)*sizeof(char));

    if(usarorden == NULL){
        printf("No se pudo establecer memoria correctamente.\n");
        exit(1);
    }

    int i;

    for(i = 0; i<lon ; i++){
        usarorden[i] = num[lon -1 -i];
    }
    usarorden[i] = '\0';


    return usarorden;

}

char * sumaStrings(char *num1 , char *num2){

    char *num1orden = ordenar(num1); char *num2orden = ordenar(num2);

    long int lon1 = strlen(num1) ; long int lon2 = strlen(num2);
    long int Truelong = lon1 > lon2 ? lon1 : lon2;

    //printf("largo del mayor: %ld\n",Truelong);
    //ya tengo el nuevo char y el largo maximo, ahora debo hacer la suma.

    char *suma = (char *)malloc((Truelong + 2) * sizeof(char));
    
    char *sumainvertir;

    int i; int recorrido = 0;

    for(i = 0 ; i < Truelong ; i++){
        int digit1 = i < lon1 ? num1orden[i] - '0': 0 ; int digit2 = i < lon2 ? num2orden[i] - '0' : 0;

        int sum = digit1 + digit2 + recorrido;

        recorrido = (sum / 10);

        suma[i] = (sum % 10 ) + '0';
        
    }

    if(recorrido == 1){
        suma[i] = '1';
    }
    
    suma[i+1] = '\0';

    sumainvertir = ordenar(suma);
    
    free(num1orden); free(num2orden); free(suma);

    return sumainvertir;
}   