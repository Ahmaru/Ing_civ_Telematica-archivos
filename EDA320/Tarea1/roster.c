#include "ravk.h"

//Append
void initLSE(char_t* head, char* nombre, float ataque, float defensa, float vida, float suerte){
    noob_t* nuevo = iniciarNewStudent(nombre,ataque,defensa,vida,suerte);

    if(head->roster == NULL){
        head->roster = nuevo;
    }else{
        noob_t* recorredor = head->roster;
        while(recorredor->sgte != NULL){
            recorredor = recorredor->sgte;
        }
        recorredor->sgte = nuevo;
    }

}

noob_t* iniciarNewStudent( char* nombre, float ataque, float defensa, float vida, float suerte){
    noob_t* pointer = malloc(sizeof(noob_t));
    //pointer->nombre = malloc(sizeof(char)*strlen(nombre));

    pointer->nombre = strdup(nombre);
    pointer->ataque = ataque;
    pointer->defensa = defensa;
    pointer->vida = vida*1000;
    pointer->suerte = suerte;
    pointer->sgte = NULL;
    pointer->stats_ataque = pointer->stats_defensa = pointer->stats_vida = NULL;

    return pointer;
}


//ubica un estudiante y lo retorna en base a su nombre.
noob_t* ubiEst(char_t* cabeza, char* name){

    while(1){
        noob_t* recorredor = cabeza->roster;
        while(recorredor != NULL){
            if(strcmp(recorredor->nombre,name) == 0){
                return recorredor;
            }else{
                recorredor = recorredor->sgte;
            }
        }
        printf("Nombre erroneo.\n");
        return Select(cabeza);
    }

}

//usa ubiEst y retorna un estudiante que ha sido seleccionado para luchar.
noob_t* Select(char_t* cabeza){
    char nombre[50];

    printf("Select your characther\n");

    showEstEDA(cabeza);

    printf("Ingrese nombre de su luchador: ");
    scanf("%s%*c",nombre);

    nombre[strcspn(nombre,"\n")] = '\0';

    return ubiEst(cabeza,nombre);

}

//Muestra los estudiantes por orden decendente.
void showEstEDA(char_t* cabeza){

    noob_t* recorredor = cabeza->roster;
    int i = 1;

    while(recorredor != NULL){
        printf("\t(%d)%s Ataque(%.2f) Defensa(%.2f) Vida(%.2f) Suerte(%.2f)\n",i,recorredor->nombre,recorredor->ataque,recorredor->defensa,recorredor->vida,recorredor->suerte);
        recorredor = recorredor->sgte;
        i++;
    }

}

void mostrarEstudianteActual(noob_t* player){
    printf("Estadisticas del personaje \n");

    printf("\t%s\n\tAtaque: %.2f\n\tDefensa: %.2f\n\tVida: %.2f\n\tSuerte: %.2f\n",player->nombre,player->ataque,player->defensa,player->vida,player->suerte);

}

//Limpieza de los nodos.
void cleanEst(char_t* cabezaEst){

    while(cabezaEst->roster != NULL){
        noob_t* recorredorInt = cabezaEst->roster;
        cabezaEst->roster = recorredorInt->sgte;

        if(recorredorInt->stats_ataque != NULL){ freeSTACK(recorredorInt->stats_ataque); }
        if(recorredorInt->stats_defensa != NULL){ freeSTACK(recorredorInt->stats_defensa); } 
        if(recorredorInt->stats_vida != NULL){ freeSTACK(recorredorInt->stats_vida); }

        free(recorredorInt->nombre);
        free(recorredorInt);
    }
    //printf("Se ha liberado la EDA de estudiantes_elegibles.\n\n");
}

//Nueva funcion para ver atributos de un player.
void showNewAtributtes(noob_t* player){
    printf("Estadisticas de %s : \n",player->nombre);
    printf("Ataque: %.2f Defensa: %.2f Vida: %.2f Suerte: %.2f\n",player->ataque,player->defensa,player->vida,player->suerte);
}