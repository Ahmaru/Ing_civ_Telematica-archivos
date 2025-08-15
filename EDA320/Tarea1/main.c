#include "ravk.h"

int main(int argc , char** argv){

    //Escoger dos EDAS.
    //Lista Simplemente Enlazada
    char_t* cabeza = malloc(sizeof(char_t));
    if(cabeza == NULL){
        printf("Error asignando memoria.\n");
        return -1;
    }
    cabeza->roster = NULL;

    //Creare 3 LDE de profes para ordenar .
    profe_t* facil = NULL;
    profe_t* medio = NULL;
    profe_t* dificil = NULL;
    int size = 3;

    tower_t** inicio = malloc(sizeof(tower_t*)*size);
    if(inicio == NULL){
        printf("Error asignando memoria.\n");
        return -1;
    }
    for(int j = 0 ; j < size ; j++){
        inicio[j] = malloc(sizeof(tower_t));
        if(inicio[j] == NULL){
            printf("Error al asignar memoria.\n");
            return -1;
        }
        inicio[j]->head = NULL;
    }

    //LDE
    FILE* estudiantes = fopen("estudiantes_elegibles.csv","r");
    if(estudiantes == NULL){
        printf("Error en la apertura.\n");
        return -1;
    }
    char buffer[256];

    //Sabiendo que tiene el formato nombre;ataque;defensa;vida;suerte
    char n[50];
    float a,d,v,l;

    while(fgets(buffer,256,estudiantes) != NULL){
        buffer[strcspn(buffer,"\n")] = '\0';
        char* token = strtok(buffer,";");
        strcpy(n,token);
        token = strtok(NULL,";");
        a = atof(token);
        token = strtok(NULL,";");
        d = atof(token);
        token = strtok(NULL,";");
        v = atof(token);
        token = strtok(NULL,";");
        l = atof(token);

        initLSE(cabeza,n,a,d,v,l);
    }
    fclose(estudiantes);
    
    FILE* profesores = fopen("profesores_npc.csv","r");
    if(profesores == NULL){
        printf("Error en la apertura de archivo.\n");
        return -1;
    }
    //Sabiendo el formato nombre;ataque;defensa;vida;nivel_desafio;premio
    char award[20];
    float dif;

    while(fgets(buffer,256,profesores)){
        buffer[strcspn(buffer,"\n")] = '\0';
        char* token = strtok(buffer,";");
        strcpy(n,token);
        token = strtok(NULL,";");
        a = atof(token);
        token = strtok(NULL,";");
        d = atof(token);
        token = strtok(NULL,";");
        v = atof(token);
        token = strtok(NULL,";");
        dif = asignarDIF(token);
        token = strtok(NULL,";");
        strcpy(award,token);

        if((int)dif == 1){
            iniciarLISTA(&facil,n,a,d,v,dif,award);
        }else if((int)dif == 2){
            iniciarLISTA(&medio,n,a,d,v,dif,award);
        }else if((int)dif == 3){
            iniciarLISTA(&dificil,n,a,d,v,dif,award);
        }
    }
    fclose(profesores);

    //Iniciar torre facil con 7 faciles y 3 medios.
    {
        appendFACIL(inicio[0],&facil,7);
        appendFACIL(inicio[0],&medio,3);
    }

    //Iniciar torre media con reglas: 5 faciles, 4 medios, 1 dificil.
    {
        appendFACIL(inicio[1],&facil,5);
        appendFACIL(inicio[1],&medio,4);
        appendFACIL(inicio[1],&dificil,1);
    }

    //Iniciar torre dificil con sus reglas, 5 de cada dificultad.
    {
        appendFACIL(inicio[2],&facil,5);
        appendFACIL(inicio[2],&medio,5);
        appendFACIL(inicio[2],&dificil,5);
    }

    menuTorneo(inicio,cabeza,&facil,&medio,&dificil,size);

    liberarMemoriaTorneo(inicio,&facil,&medio,&dificil,cabeza,size);

    free(cabeza);
    for(int i  = 0 ; i < size ; i++){
        free(inicio[i]);
    }
    free(inicio);

    free(facil);
    free(medio);
    free(dificil);

    return 0;
}