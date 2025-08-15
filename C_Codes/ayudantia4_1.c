/*#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct motor{
    char Potencia[20];
    //Mientras más alto más te odian.
    char Sonido[20];

}m;

typedef struct carroza{
    char marca[25];
    char cantRuedas[5];
    char color[20];
    m motorzini;

}c;

void initAutito(int cant , char** datos,c *car);
void showAutito(c *car);


int main(int argc, char** argv){

    c autito;

    if(argc != 6){
        printf("No hay argumentos suficientes.\nDebe ingresar el color, la cantidad de ruedas, la potencia y el sonido que genera.\n");
        return -1;
    }

    initAutito(argc,argv,&autito);

    showAutito(&autito);

    return 0;
}

void initAutito(int cant , char** datos, c *car){
    strcpy(car->marca,datos[1]);
    strcpy(car->cantRuedas,datos[2]);
    strcpy(car->color,datos[3]);
    strcpy(car->motorzini.Potencia,datos[4]);
    strcpy(car->motorzini.Sonido,datos[5]);
}

void showAutito(c *car){
    printf("Auto rikitiki: \nMarca: %s, color %s \nPotencia: %s , suena %s\n",car->marca,car->color,car->motorzini.Potencia,car->motorzini.Sonido);
}
*/
