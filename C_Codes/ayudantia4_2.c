//Reclusos

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Recluso{

    char nombre[25];
    int years;

}recluso;

int main(int argc , char** argv){

    FILE *archivo = fopen(argv[1],"a");
    if(archivo == NULL){
        printf("Error al abrir el archivo.\n");
        return -1;
    }

    recluso one[3];
    strcpy(one[0].nombre,argv[2]);
    one[0].years = atoi(argv[3]);

    strcpy(one[1].nombre,argv[4]);
    one[1].years = atoi(argv[5]);

    strcpy(one[2].nombre,argv[6]);
    one[2].years = atoi(argv[7]);

    for(int i = 0 ; i<3 ; i++){
        fprintf(archivo,"Nombre: %s ,años: %d .\n",one[i].nombre,one[i].years);
    }

    fclose(archivo);
    return 0;
}

