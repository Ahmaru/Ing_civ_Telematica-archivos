#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct LDEE{
    
    char* name;
    int value;
    struct LDEE *stge;
    struct LDEE *prev;    
}ListaDE;


//desde los argumentos ingresar valores para agregarlos a la lista y poder hacer una interaccion rapida.
int main(int agrc , char* argv[] ){

    ListaDE * init = NULL;

    for(int i = 1 ; i < strlen(argv) ; i+2){
        append(&init,argv[(i+1)],atoi(argv[i+2]));
    }


    return 0;
}

void append(ListaDE** cabeza, char* nombre , int valor ){
    
    ListaDE * nuevo = malloc(sizeof(ListaDE));

    nuevo->name = malloc(sizeof(char)*15);

    nuevo->stge = NULL;

    if((*cabeza) == NULL){
        (*cabeza) = nuevo;
        nuevo->prev = NULL;

    }else{
        ListaDE* rec = (*cabeza);

        while(rec->stge != NULL){
            rec = rec->stge;
        }
        rec->stge = nuevo;
        nuevo->prev = rec;
    }

}
