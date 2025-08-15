#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int apuesta,numero_caballo;
    char* nombre_caballo;
} caballos ;

typedef struct {
    caballos *struct_caballo;
    size_t cantidad;
    size_t capacidad_array;
} array_dinamico;


int main(){

}