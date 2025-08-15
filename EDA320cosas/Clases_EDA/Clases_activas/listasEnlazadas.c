#include <stdio.h>
#include <stdlib.h>


typedef struct nodo{
    int dato;
    struct nodo* stge;

} node;

void DeterminarLargo(node** lindo); void initLista(node** lindo);


int main(int argc , char **argv){
    node* nodito = NULL;


}   

void initLista(node** lindo,int dato){
    node* cabezero = malloc(sizeof(node));

    cabezero->dato = dato;
    cabezero->sgte = NULL;
    
    *lindo = cabezero;
}

void DeterminarLargo(node** lindo){
    node* cabezero = malloc(sizeof(node));

    



}