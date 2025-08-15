#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*typedef struct nodo{
    int dato;
    struct nodo* sgte;
} nodo_t;

typedef struct le_nodo{
    float dato[20];
    struct le_nodo* sgte;
    struct le_nodo* prev;
}nodo_t;

void admiddle(nodo_t* cabeza,int dato,int posicion);

int main(int argc, char** argv){
    
    nodo_t* inicio = NULL;
    //nodo_t* final = NULL;



    return 0;
}

void admiddle(nodo_t* cabeza,int dato,int posicion){
    nodo_t *nuevo = malloc(sizeof(nodo_t));int contador;

    *nuevo->dato = dato;
    nodo_t *recorre = cabeza;

    for(contador = 0;contador < posicion;contador++){
        recorre = recorre->sgte;
    }
    nuevo->prev = recorre->prev;
    if(recorre->prev != NULL){
        (recorre->prev)->sgte = nuevo;
    }else{
        recorre->prev->sgte = NULL;
    }
    nuevo->sgte = recorre;
    recorre->prev = nuevo;

}*/

typedef struct le_nodo{
    char palabra[10];
    struct le_nodo *sgte;
    struct le_nodo *prev;
}nodo;

void EliminarDuplicados(nodo *cabeza,char dato[10],nodo *listab);void LlenarLista(nodo **cabeza,char cosita[10]);

int main(int argc,char **argv){
    char cositas[7][10] = {"manzana","plátano","uva","manzana","pera","plátano","uva"};
    nodo **insertar = NULL;

    for(int i = 0;i<7;i++){
        LlenarLista(insertar,cositas[i]);
    }

    nodo *borrados = NULL;


}

void EliminarDuplicados(nodo *cabeza,char dato[10],nodo *listab){
    char statico[10];
    while(cabeza != NULL){

    }

}

void LlenarLista(nodo **cabeza,char cosita[10]){
    nodo *nueo = malloc(sizeof(nodo));

    if(nueo == NULL){
        printf("Error al asignar espacio.");
        exit(1);
    }

    strcpy(nueo->palabra,cosita);
    nodo *recorredor = (*cabeza);

    if(recorredor == NULL){
        nueo->sgte = (*cabeza);
        nueo->prev = NULL;
        *cabeza = nueo;

    }else{

        while(recorredor->sgte != NULL){
        recorredor = recorredor->sgte;
        }

        nueo->prev = recorredor;
        nueo->sgte = recorredor->sgte;
        recorredor->sgte = nueo;
}

}
