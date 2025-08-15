#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<unistd.h>

typedef struct nivel_de_mejoras{
    char * premio;
    int contador;
    struct nivel_de_mejoras * sgte;
}stats_t;

typedef struct estudiante{
    char * nombre; // nombre del estudiante
    float ataque;
    float defensa;
    float vida; 
    float suerte;  // ratio de suerte
    stats_t * stats_ataque; // nivel de mejoras: ataque 
    stats_t * stats_defensa; // nivel de mejoras: defensa
    stats_t * stats_vida; // nivel de mejoras: vida
    struct estudiante * sgte;
}noob_t;

typedef struct profesor{
    char * nombre; // nombre del profesor
    float ataque; 
    float defensa;
    float vida;
    float modo_dificultad; // ratio de dificultad
    char * premio; // string de recompensa
    struct profesor * sgte;
    struct profesor * prev;
}profe_t;

typedef struct seleccion{
    noob_t *roster; 
}char_t;

typedef struct torre{
    int nro_de_profes;
    profe_t * head;
}tower_t;

//Inicializador de EDA para alumnos

noob_t* iniciarNewStudent( char* nombre, float ataque, float defensa, float vida, float suerte);
void initLSE(char_t* head, char* nombre, float ataque, float defensa, float vida, float suerte);

//Limpiador eda alumnos.

void cleanEst(char_t* caeza);

//FUNCIONES PARA *roster.c*

noob_t* ubiEst(char_t* cabeza, char* name);
noob_t* Select(char_t* cabeza);
void showEstEDA(char_t* cabeza);
void showNewAtributtes(noob_t* player);
void mostrarEstudianteActual(noob_t* player);

//Inicializador de EDA para profes

profe_t* initPROFE(char* nombre, float ataque , float defensa , float vida , float dif , char* premio);
void initTOWER(tower_t* torrecita,char* nombre, float ataque , float defensa , float vida , float dif , char* premio);

//Limpiador EDA profes.

void cleanLDE(profe_t** final);
void cleanTOWER(tower_t* cabeza);

//Funciones para towers.c
void agregar(tower_t* torre, profe_t* profe);
void CountLDE(profe_t* cabeza);
float asignarDIF(char* tkn);
void showTORRE(tower_t* cabeza);
void createTOWER(tower_t** torres,profe_t** facil,profe_t** medio,profe_t** dificil, int *size);
void showprofe(profe_t* profe);

//Funciones para separar 
void iniciarLISTA(profe_t** iniciar,char* nombre, float ataque , float defensa , float vida , float dif , char* premio);
void appendFACIL(tower_t* torre, profe_t** inicio, int cant);

//Funciones tournament.c
void Hundredtality(int golpes);
int pelea(profe_t* enemy, noob_t* player);
void añadirSTAT(noob_t* player,char* agregar);
void freeSTACK(stats_t* stack);
int TOURNAMENT(tower_t* torre, noob_t* player);
tower_t* SelectTOWER(tower_t** torres,noob_t* player,int size);
void showTorreDif(tower_t* torre,int contador);
void asignacionDatosProfe(tower_t** torres,profe_t** f,profe_t** m, profe_t** di);
void asignarDatos(char_t* roster);
void menuTorneo(tower_t** torres, char_t* roster,profe_t** facil,profe_t** medio, profe_t** dificil,int size);
void remakeTower();
void moveProfeslosers(profe_t* actual, profe_t** guardar);
void showAvance(tower_t* torre,noob_t* player);
int ULTIMATEchampion();
int GAMEOVER();
void liberarMemoriaTorneo(tower_t** torres, profe_t** facil,profe_t** medio, profe_t** dificil, char_t* roster,int size);

