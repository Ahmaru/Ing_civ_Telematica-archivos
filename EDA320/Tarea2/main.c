#include "discordia.h"

int main(int argc , char* argv[]){

    pix_t* imagen = NULL;
    pix_t* cola = NULL;
    char* palabras[] = {"botella","pointers","memes", "aprobarEDA","intarray","pointers","voidptr","fullpointers"};
    int tamaños[] = {8,9,6,11,9,9,8,14};

    if(argc < 9 ){
        printf("Faltan argumentos o sobran XD.\n");
        exit(1);
    }

    menuGame(&imagen,&cola,argv,palabras,tamaños);

    liberarPixel(&imagen);
    free(imagen);

    return 0;
}