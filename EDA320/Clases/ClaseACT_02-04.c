#include <stdio.h>
#include <stdlib.h>

void imprimir_datos(int* arreglo , int tam);
void promedio(int* arreglo , int tam, float* prom);

int main(){

    int * numbers = malloc(sizeof(int)*10);

    float* prom = malloc(sizeof(float));

    for(int i = 0 ; i<10 ; i++){
        *(numbers + i) = i*(i+1);
    }

    promedio(numbers,10,prom);

    imprimir_datos(numbers,10);

    printf("promedio: %.3f\n",*prom);

    free(numbers);

    return 0;
}

void imprimir_datos(int* arreglo,int tam){

    int sum;

    for(int i = 0 ; i < tam ; i++){
        printf("posicion: %d Valor: %d\n",i+1,arreglo[i]);
        sum += *(arreglo + i);
    }
    printf("suma: %d\n",sum);

}

void promedio(int* arreglo , int tam, float* prom){
    
    //float inside;

    for(int i = 0 ; i<tam ; i++){
        (*prom) += *(arreglo + i);
    }

    (*prom) = (*prom)/tam;
}