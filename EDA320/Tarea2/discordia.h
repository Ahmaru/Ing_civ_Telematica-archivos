#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include <Imlib2.h>
#include <math.h>
#include <string.h>

typedef struct pixel {
    long int id; // id del conjunto de datos del pixel .
    int red; // valor del color rojo del pixel .
    int green; // valor del color verde del pixel .
    int blue; // valor del color azul del pixel .
    struct pixel* sgte; //para manejarlo como una estructura de datos.
}pix_t;


//Para guardar me tinca una LDE
void leerArchivo(char* linea, pix_t** guardaPixels,pix_t** colita);
int* separarRGB(char* RGB);
int checker(char* entra);
int SelectIMG(char** listaimg,int size);
void liberarPixel(pix_t** pixeles);
pix_t** to_array(pix_t* head, int size);

//Separacion para menu y pre-ordenamiento
void menuGame(pix_t** pixeles,pix_t** pixelesCola,char** argumentos,char** listaPalabras,int* tamaños);
void interno(char* correcta,int size,pix_t* pixelsito, char* tamaño, char* tipo, char* maxpix);
int verificador(char* intento,char* correct,int tamaño);
void makeppmFinal(pix_t* pixeles,int columna,int filas,char* tamaño,char* tipo,char* maxpix);
void makeppmParcial(pix_t** pixeles,int size,char* tamaño,char* tipo,char* maxpix,int cantpix);

//Para los ordenamientos.
void RadixSortArr(pix_t** arr, int size);
void CountingSortArr(pix_t** arr, int size, int exp);
long int findMaximum(pix_t* pixeles,int size);

void MergeSortArr(pix_t** arr, int l, int r);
void merge(pix_t** arr, int l, int m, int r);

void InsertionSortArr(pix_t** arr, int size);



