#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct Recluso{

    char nombre[25];
    int years;

}recluso;


int main(int argc,char** argv){

    if(argc != 4){
        printf("no hay suficientes argumentos.\n");
        return -1;
    }

    char *persona = malloc(sizeof(char)*20);
    strcpy(persona,argv[2]);

    FILE *archivito = fopen(argv[1],"r");
    if(archivito == NULL){
        printf("Error al abrir el archivo.\n");
        return -1;
    }

    char buffer[256];
    int conteo = 0;

    while(fgets(buffer,sizeof(buffer),stdin) != NULL){
        if(strcmp(buffer[1],persona) && atoi(argv[3])== 3){
            strcpy(buffer,"Recluso liberado.\n");

        }else if(strcmp(buffer[1],persona) && atoi(argv[3])== 3){
            int valor = atoi(buffer[3]);
            valor = 0;
            buffer[3] = valor;
        }else if(strcmp(buffer[1],persona) && atoi(argv[3])== 3){
            conteo++;
        }

    }

    if(atoi(argv[3])== 3){
        printf("Se repite: %d\n",conteo);
    }

    fclose(archivito);

    return 0;
}
