//Anagramas
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int largostrsMax = 1000;
static int largocolumnMax = 100;

void groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSize);

int main(int argc , char** argv){
    char** arreglo = (char**)malloc(largostrsMax * sizeof(char*));
    int largoarreglo = 0;
    char* recibir = (char*)malloc(largostrsMax*sizeof(char));
    const char delimitador[2] = ",";

    if(arreglo == NULL){
        printf("Error al asignar memoria"); 
        exit(1);
    }
    for(int i = 0; i <largostrsMax; i++){
        arreglo[i] = (char*)malloc(largocolumnMax*sizeof(char));
        printf("0");

        if(arreglo[i] == NULL){
            printf("error al asignar memoria");
            exit(1);
        }

    }

    printf("Ingrese la lista a ordenar separada por comas: ");

    printf("1\n");

    if(fgets(recibir,1000,stdin) == NULL){
        printf("Error en la entrada\n");
        exit(1);
    };
    //printf("1");

    recibir[strcspn(recibir,"\n")] = '\0';

    char* conteo = strtok(recibir,delimitador);
    largoarreglo++;

    int i = 0; int *largodepalabras = NULL;
    while(recibir != NULL){
        arreglo[i] = conteo;
        //printf("1");
        largoarreglo++;
        i++;

        largodepalabras[i] = strlen(conteo);
        conteo = strtok(NULL,delimitador);
    }

    int column;
    while(largodepalabras[column] != '\0'){
        column++;
        printf("2");
    }

    free(recibir);
    free(conteo);

    groupAnagrams(arreglo,largoarreglo,largodepalabras,column);


    for(int i = 0; i < column;i++){
        free(arreglo[i]);
        printf("3");

    }   
    free(arreglo);
    return 0;

}

void groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSize){
    char agrupar[strsSize];

    
    for(int i = 0; i<strsSize;i++){
        

        for(int j = 0; j < returnSize[i];j++){
            //strs[i][j];
            printf("Esta wea: %c",strs[i][j]);
        }

    }
}

