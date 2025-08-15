#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//defino valores para Asistencio o inasistencia.
#define asistio 1;
//#define falto 0;

/*EDA en la que basare el codigo en total: Lista doblemente enlazada*/
typedef struct nodo{
    char* nombre; // Nombre; recuerde que un char* es simplemente una string.
    int** asistencia_semanal; // Asistencia, recuerde que un int** es simplemente un arreglo de arreglo de enteros.
    struct nodo *sgte; // Puntero de control que apuntará al siguiente.
    struct nodo *prev; // Puntero de control que apuntará al anterior.
}nodo_t ;

//Definire Funciones para lista doblemente enlazada.

/*Funciones para asistencia.c */
char** GuardarFechas(char** Array,int* cantF);

char* agregarTXT(char* FechaInteres);

void AñadirEstudiante(nodo_t **cabeza,char* name);

void ShowAttendanceEst(nodo_t *cabeza,char* NomInteres,int dias,int semanas, char** fechas);    

void CreateSpace(nodo_t *cabeza,int days, int semanas);

void AsistenciaDia(nodo_t* cabeza,char** filename,int days ,int weeks, int EstudiantesEDA);

int CantidadEstTotales(nodo_t* cabeza);

int BuscarEst(nodo_t* cabeza,char* Nombrebusqueda);

void Vaciar(nodo_t** cabeza);

//Esta funcion es para liberar toda la memoria dinamica que hice y no se utilizara despues de la recopilacion de informacion de los archivos.
void LiberarMemoria(nodo_t* cabeza,char** arrays,char** array2,int dias, int Semanas);

/*Funciones para analisis.c */
void EscribirCSV(nodo_t* cabezal,int dias,char** fechas);

void eliminarSaltoDeLinea(char* str);
