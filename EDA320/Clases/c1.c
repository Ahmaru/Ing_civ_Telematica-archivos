#include <stdio.h>
#include <stdlib.h>

typedef struct ABB{
    int dato;
    struct ABB *izq, *der;
} tree;

void add_sucesor(tree* raiz,int dato){

    if(raiz->dato < dato && raiz != NULL){
        add_sucesor(raiz->der,dato);
        return;
    }
    if(raiz->izq == NULL){
        tree* nuevo = malloc(sizeof(tree));
        nuevo->dato = dato;
        nuevo->der = NULL;
        nuevo->izq = NULL;
        
        raiz->izq = nuevo;
        return;
    }
    add_sucesor(raiz->izq,dato);
}
