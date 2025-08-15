#include "Funciones.h"

int main(){
    int largo = MAX_LENGHT;
    int* array = (int*)malloc(largo * sizeof(int));
    if(array == NULL){
        printf("Error al asignar memoria.\n");
        exit(1);
    }

    srand(time(NULL));

    AsignarNMBR(array,largo);

    menuLindo(array,largo);

    free(array);

    return 0;
}

