#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_LENGHT 10000000 


typedef struct algoritmo{
    char* nombre;
    double tiempo;

}sort;



//Aqui definir funciones o todo lo que sea util.Como variables globales, structs, etc.

void imprimir(int *p, int length);

int GenerarNumRandom();

void AsignarNMBR(int* arreglo,int largo);

void WriteCSV(double Time1 , double Time2 , double Time3 , int* array , int largo,int* arrayordenado );

void menuLindo(int* array , int tamano);

int power(int base , int potencia);

void LLenarstruct(sort* ordenable,double Time_n2 , double Time_nlogn , double Time_lineal );

//funcion para crear arreglos temporales para cada funcion y que no cambien su contenido.
void CreateSPCEarray(int* entrada, int* copia,int largo);

/*
Hare un MergeSort para el BigO (n log n)

Defino las funciones Merge y MergeSort para el algoritmo.

*/

//MERGESORT

void Merge(int* array, int izq , int medio , int der);

void MergeSort(int* array, int izq , int der);


/*
Para el BigO (N²) Usare un selection sort
Hice una funcion swap para rapidez del algoritmo y comodidad.

*/

void swap(int *a , int *b);

void SelectionSort(int* p, int length);

/*
Para el BigO (n) lineal.

Counting Sort o RadixSort LSD

Como su implementacion puede ser: radix sort con counting sort para mayor comodidad o directamente  
el counting sort.

Como son tantos datos me convienen ambos ya que trabajan juntos.

*/

//en este caso esta funcion no es necesaria.
void FindMAX_MIN(int* array , int largo , int* max , int* min);

int* ManejarArreglosAX(int* auxrray ,int largocount);

void CountingSort(int* array , int largo , int lugar);

//RADIX

int maximo(int* array , int largo);

void RadixSort(int* array, int size);
