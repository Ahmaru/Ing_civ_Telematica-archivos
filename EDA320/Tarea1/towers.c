#include "ravk.h"

//Torre facil: 7 faciles, 3 normal
//Torre media: 5 faciles, 4 normal , 1 dificil
//Torre dificil: 5 faciles , 5 normal,  5 dificil 

//LDE
profe_t* initPROFE(char* nombre, float ataque , float defensa , float vida , float dif , char* premio){ 
    profe_t* nuevo = malloc(sizeof(profe_t));

    //Sabiendo el formato nombre;ataque;defensa;vida;nivel_desafio;premio
    nuevo->nombre = strdup(nombre);
    nuevo->ataque = ataque;
    nuevo->defensa = defensa;
    nuevo->vida = vida*1000;
    nuevo->modo_dificultad = dif;
    nuevo->premio = strdup(premio);
    nuevo->sgte = NULL;
    nuevo->prev = NULL;

    //free(nombre);
    //free(premio);

    return nuevo;
}

//Append a una lista doblemente enlazada.
void initTOWER(tower_t* torrecita, char* nombre, float ataque , float defensa , float vida , float dif , char* premio){
    profe_t* nuevo = initPROFE(nombre,ataque,defensa,vida,dif,premio);

    if(torrecita->head == NULL){
        torrecita->head = nuevo;
    }else{
        profe_t* recorre = torrecita->head;

        while(recorre->sgte != NULL){
            recorre = recorre->sgte;
        }
        recorre->sgte = nuevo;
        nuevo->prev = recorre;
    }
}

void CountLDE(profe_t* cabeza){
    profe_t* recorredor = cabeza;
    //int i = 0;
    while(recorredor != NULL){
        printf("\t%s atack(%.2f) defence(%.2f) life(%.2f) difficulty(%.2f) reward(%s)\t\n",recorredor->nombre,recorredor->ataque,recorredor->defensa,recorredor->vida,recorredor->modo_dificultad,recorredor->premio);
        //i++;
        recorredor = recorredor->sgte;
    }
    //printf("Total: %d\n",i);

}

void showprofe(profe_t* profe){
    printf("\t%s atack(%.2f) defence(%.2f) life(%.2f) difficulty(%.2f) reward(%s)\t\n",profe->nombre,profe->ataque,profe->defensa,profe->vida,profe->modo_dificultad,profe->premio);
}

float asignarDIF(char* tkn){
    
    if(strcmp("facil",tkn) == 0){ return (float)1;}
    if(strcmp("medio",tkn) == 0){ return (float)2;}
    if(strcmp("dificil",tkn) == 0){ return (float)3;}

    printf("\nMal\n.");
    return -1;
}

void cleanTOWER(tower_t* cabeza){

    while(cabeza->head != NULL){
        profe_t* rec = cabeza->head;
        cabeza->head = cabeza->head->sgte;
        //cabeza->head->prev = NULL;
        free(rec->nombre);
        free(rec->premio);
        free(rec);
    }
    //printf("Limpieza de torre.\n");
}

void showTORRE(tower_t* cabeza){
    CountLDE(cabeza->head);
}

void cleanLDE(profe_t** final){

    while((*final) != NULL){
        profe_t* recorredor = (*final);
        (*final) = (*final)->sgte;
        free(recorredor->nombre);
        free(recorredor->premio);
        free(recorredor);
    }
    free((*final));
    //printf("Se ha limpiado la EDA de profes.\n");
}

int countingEDA(tower_t* columna){
    return columna->nro_de_profes;
}

void createTOWER(tower_t** torres,profe_t** facil,profe_t** medio,profe_t** dificil, int *size){
    tower_t* nueva = malloc(sizeof(tower_t));
    (*size)++;
    int a;

    printf("Reglas para agregar torre. \n-Se usaran los profesores sobrantes o creados por el usuario.\n-Las torres seguiran el formato: \n\t(1)Torre facil 7 faciles, 3 medios\n\t(2)Torre media 5 faciles, 4 medios y 1 dificil\n\t(3)Torre dificil 5 de cada dificultad.\n");
    
    while(1){
        printf("Ingrese el tipo de torre que desea agregar: ");
        scanf("%d%*c",&a);

        if(a == 1){
            appendFACIL(nueva,facil,7);
            appendFACIL(nueva,medio,3);
            break;
        }else if(a == 2){
            appendFACIL(nueva,facil,5);
            appendFACIL(nueva,medio,4);
            appendFACIL(nueva,dificil,1);
            break;
        }else if(a == 3){
            appendFACIL(nueva,facil,5);
            appendFACIL(nueva,medio,5);
            appendFACIL(nueva,dificil,5);
            break;
        }else{
            printf("\n\tIngrese un numero correcto.\n");
        }
    }

    torres = realloc(torres,(*size)*sizeof(tower_t*));
    if(torres == NULL){
        perror("realloc fallo.\n");
        exit(1);
    }
    torres[(*size)-1] = nueva;
}

tower_t* SelectTOWER(tower_t** torres,noob_t* player,int size){
    printf("Selecciona la torre a desafiar.\n");
    int seleccion, n = 0;

    while(n < size){
        showTorreDif(torres[n],n);
        n++;
    }
    scanf("%d%*c",&seleccion);
    return torres[(seleccion -1)];
}

//Funciones para el ordenamiento de las torres.
void iniciarLISTA(profe_t** iniciar,char* nombre, float ataque , float defensa , float vida , float dif , char* premio){
    profe_t* nuevo = initPROFE(nombre,ataque,defensa,vida,dif,premio);

    if((*iniciar) == NULL){
        (*iniciar) = nuevo;
    }else{
        profe_t* recorre = (*iniciar);
        while(recorre->sgte != NULL){
            recorre = recorre->sgte;
        }
        recorre->sgte = nuevo;
        nuevo->prev = recorre;
    }
}

void appendFACIL(tower_t* torre, profe_t** inicio, int cant){
    int i;
    for(i = 0; i < cant ; i++){
        profe_t* rec = (*inicio);
        (*inicio) = (*inicio)->sgte;
        rec->sgte = NULL;
        rec->prev = NULL;
        agregar(torre,rec);
    }
    torre->nro_de_profes += (i+1);
}

void agregar(tower_t* torre, profe_t* profe){

    if(torre->head == NULL){
        torre->head = profe;
    }else{
        profe_t* rec = torre->head;

        while(rec->sgte != NULL){
            rec = rec->sgte;
        }
        rec->sgte = profe;
        profe->prev = rec;
    }
}

