#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*Codigo que usa nodos para pilas y colas con push y pop para pilas, enqueue y dequeue para cola. */

typedef struct elnodo{
    char palabra[10];
    struct elnodo *sgte;

}n;

/*
void push(n** cabeza,char palabra[10]); void ImprimirLista(n* cabeza);void pop(n** cabeza);

int main(int argv, char** argc){
    n* top = NULL;
    char lindo[4][10] ={"pemnes","lectura","sexual","niga"};
    

    for(int i = 0; i < 4;i++){
        push(&top,lindo[i]);
    }

    ImprimirLista(top);

    for(int i = 0 ; i < 4; i++){
        pop(&top);
        ImprimirLista(top);
    }

    free(top);

    return 0;

}

void push(n** cabeza,char palabra[10]){
    n* nueo = malloc(sizeof(n));
    
    strcpy(nueo->palabra,palabra);

    nueo->sgte = (*cabeza);

    (*cabeza) = nueo;

}

void ImprimirLista(n* cabeza){
    n* recorredor = cabeza;
    int i = 0;

    while(recorredor != NULL){
        printf("Palabra en nodo[%d]: %s\n", i ,recorredor->palabra);
        //palabra[i] = recorredor->palabra;
        recorredor = recorredor->sgte;
        i++;
    }
}

void pop(n** cabeza){
    printf("Se borrará el objeto más reciente.\n");

    n* cabezal = *cabeza;

    *cabeza = (*cabeza)->sgte;

    free(cabezal);
}



void enqueue(n** cabeza,n** Final,char name[10]);void Imprimir(n* cabeza);void dequeue(n** cabeza);

int main(int argv, char** argc){
    n* Inicio = NULL;
    n* Final = NULL;

    char nombres[5][10] = {"Maru","Antonio","Sea","KIKUO","Penesito"};

    for(int i = 0; i < 5; i++){
        enqueue(&Inicio,&Final,nombres[i]);
    }

    Imprimir(Inicio);

    for(int i = 0; i<5 ; i++){
        dequeue(&Inicio);
        Imprimir(Inicio);
    }

    Imprimir(Inicio);

    //free(Inicio);
    //free(Final);

    return 0;
}

void enqueue(n** cabeza,n** Final,char name[10]){
    n* nueo = malloc(sizeof(n));
    strcpy(nueo->palabra,name);
    nueo->sgte = NULL;


    if((*Final) == NULL){
        (*cabeza) = nueo;
        (*Final) = nueo;

    }else{
        (*Final)->sgte = nueo;
        (*Final) = nueo;

    }    
}

void Imprimir(n* cabeza){
    n* recorredor = cabeza; 
    int i = 0;

    while(recorredor != NULL){
        printf("Nombre en la posicion[%d]: %s\n",i,recorredor->palabra);
        recorredor = recorredor->sgte;
        i++;
    }
}

void dequeue(n** cabeza){
    n* guardar = (*cabeza);
    (*cabeza) = (*cabeza)->sgte;

    free((guardar));
}

*/


