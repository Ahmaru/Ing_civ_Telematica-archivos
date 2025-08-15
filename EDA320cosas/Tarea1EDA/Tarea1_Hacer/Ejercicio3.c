/*Este ejercicio agrupa anagramas y los muestra por pantalla en conjunto a sus pares*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*Aqui defino las funciones*/
void groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSize);
void guardarcosas(char** strs, int strsSize, int** returnColumnSize);

/*Defino el main*/
int main(){
    char palabra[1000];
    char* conteo = NULL;
    int** tamaño = NULL;
    int* size = NULL;
    int i = 0;

    printf("Ingrese arreglo separado por comas: ");
    if(fgets(palabra,sizeof(palabra),stdin) == NULL){
        printf("Error en la entrada.");
        exit(1);
    }

    palabra[strcspn(palabra,"\n")] = '\0';

    conteo = strtok(palabra,",");

    char** arreglo = (char**)malloc(1000 * sizeof(char*));

    while(conteo != NULL){
        arreglo[i] = malloc(strlen(conteo)+1);
        strcpy(arreglo[i],conteo);
        i++;
        conteo = strtok(NULL,",");
    } 

    guardarcosas(arreglo,i,tamaño);

    for(int j = 0; j < i ; j++){
        free(arreglo[j]);
    }

    free(arreglo);
    return 0;

}

void guardarcosas(char** strs, int strsSize, int** returnColumnSize){
    *returnColumnSize = malloc(strsSize * sizeof(int));

    for(int i = 0; i < strsSize ; i++){
        int len = strlen(strs[i]);
        (*returnColumnSize)[i] = len;
    }

    free(*returnColumnSize);
}

void groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSize){
    /*Memoria dinamente asignada.*/
    char*** arreglo = (char***)malloc(strsSize * sizeof(char**));

    for(int i = 0; i < (*returnColumnSize[i]); i++){
        arreglo[i] = (char**)malloc((*returnColumnSize)[i] * sizeof(char*));
    } 
    
    
    

}

void Agrupar(){

}
