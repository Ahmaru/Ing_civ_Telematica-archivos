#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct nodo{
    char nombre[10];
    struct nodo* sgte;
    struct nodo* prev;

}n;

void append(n** cabeza,char valor[10]);void imprimir(n* cabeza);void limpiar(n** cabeza);

int main(){
    char nombres[5][10] = {"maru","pene","sexual","ñiau","ELO"};
    n* inicial = NULL; 

    for(int i = 0; i<5;i++){
        //printf("\n1\n");
        append(&inicial,nombres[i]);
    }   

    //imprimir(inicial);

    limpiar(&inicial);

    imprimir(inicial);

    free(inicial);

    return 0;
}

void append(n** cabeza,char valor[10]){
    n* nuevo = malloc(sizeof(n));
    strcpy(nuevo->nombre,valor);
    nuevo->sgte = NULL;

    if((*cabeza) == NULL){
        (*cabeza) = nuevo;
        nuevo->prev = NULL;
        //exit(0);

    }else{
        n* recorredor = (*cabeza);

        while(recorredor->sgte != NULL){
            recorredor = recorredor->sgte;
        }
        nuevo->prev = recorredor;
        recorredor->sgte = nuevo;

        
    }
}

void imprimir(n* cabeza){
    n* recorredor = cabeza;
    int i = 0;

    while(recorredor != NULL){
        printf("In orden: %s in position [%d]\n",recorredor->nombre,i);

        recorredor = recorredor->sgte;

        i++;
    }


}

void limpiar(n** cabeza){

    while((*cabeza)->sgte != NULL){
        imprimir((*cabeza));
        n* sexual = (*cabeza);
        (*cabeza) = (*cabeza)->sgte;

        free(sexual);
    }
}
