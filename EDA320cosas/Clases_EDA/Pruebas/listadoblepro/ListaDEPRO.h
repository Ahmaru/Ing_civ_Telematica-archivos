#include <stdio.h>
#include <stdlib.h>

typedef struct nodos{
    int** value;
    struct nodos* sgte;
    struct nodos* prev;
}nigga;

void rellenar(nigga** cabeza);
