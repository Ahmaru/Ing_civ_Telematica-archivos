#include <stdio.h>
#include <stdlib.h>

typedef struct ArbolBinario{
    int valor;
    struct ArbolBin *hijoder;
    struct ArbolBin *hijoizq;

}tree;

typedef struct NodoFila{
    int value;
    struct NodoFila *sgte;
}cola;


void iniciarArbol(tree **head , int value);
void busquedaAncho(tree *head , cola** cabeza);

int main(int argc , char* argv[]){

    tree * raiz = NULL;

    int arr[] = {12,15,6,5,8,9,22,3,17};

    for(int i  = 0 ; i < 9 ; i++){
        iniciarArbol(&raiz,arr[i]);
    }

    return 0;
}

void iniciarArbol(tree **head, int value){
    tree * nuevo = malloc(sizeof(tree));
    if(nuevo == NULL){
        perror("Asignacion erronea de memoria.\n");
    }
    nuevo->hijoder = NULL;
    nuevo->hijoizq = NULL;

    

}

void busquedaAncho(tree *head , cola** cabeza){

}

