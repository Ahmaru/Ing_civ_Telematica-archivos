#include "discordia.h"

int SelectIMG(char** listaimg,int size){
    char v[50];
    
    printf("Selecciona imagen a desencriptar.\n");
    for(int i = 0; i < size; i++){
        printf("(%d)%s\n",i+1,listaimg[i]);
    }
    printf("Opcion: ");
    scanf("%s",v);
    int a = checker(v);

    while(a == 0){
        printf("seleccion incorrecta.\nIntente nuevamente\nOpcion:");
        scanf("%s",v);
        a = checker(v);
    }
    return a;
}

int checker(char* entra){
    if(strcmp(entra,"1") == 0){
        return 1;
    }else if(strcmp(entra,"2") == 0){
        return 2;
    }else if(strcmp(entra,"3") == 0){
        return 3;
    }else if(strcmp(entra,"4") == 0){
        return 4;
    }else if(strcmp(entra,"5") == 0){
        return 5;
    }else if(strcmp(entra,"6") == 0){
        return 6;
    }else if(strcmp(entra,"7") == 0){
        return 7;
    }else if(strcmp(entra,"8") == 0){
        return 8;
    }else{
        return 0;
    }
}

void leerArchivo(char* linea, pix_t** guardaPixels,pix_t** colita){
    pix_t* nuevo = malloc(sizeof(pix_t));

    char* token = strtok(linea," ");
    nuevo->id = atoi(token);
    token = strtok(NULL,"\0");
    int *oa = separarRGB(token);
    nuevo->red = oa[0];
    nuevo->green = oa[1];
    nuevo->blue = oa[2];
    nuevo->sgte = NULL;
    
    if((*guardaPixels) == NULL){
        (*guardaPixels) = nuevo;
        (*colita) = nuevo;
    }else{
        (*colita)->sgte = nuevo;
        (*colita) = nuevo;
    }
    
    free(oa);
}

//Para separar el string de RGB
int* separarRGB(char* RGB){

    int *retorn = malloc(sizeof(int)*3);

    for(int i = 0 ; i < 3 ; i++){
        retorn[i] = (RGB[(i*3)]-'0')*100 + (RGB[(i*3)+1]-'0')*10 + (RGB[(i*3)+2] - '0');
        //printf("%d\n",retorn[i]);
    }
    return retorn;
}

//Liberacion de memoria y todo.
void liberarPixel(pix_t** pixeles){
    while((*pixeles) != NULL){
        pix_t* rec = (*pixeles);
        //printf("Id actual: %d",rec->id);
        (*pixeles) = (*pixeles)->sgte;
        free(rec);
    }
}

//Ayudado por IA :(
pix_t** to_array(pix_t* head, int size) {
    pix_t** arr = malloc(size * sizeof(pix_t*));
    pix_t* curr = head;
    for (int i = 0; i < size; i++) {
        arr[i] = curr;
        curr = curr->sgte;
    }
    return arr;
}

void array_to_list(pix_t** arr, int size, pix_t** head) {
    for (int i = 0; i < size - 1; i++)
        arr[i]->sgte = arr[i + 1];
    arr[size - 1]->sgte = NULL;
    *head = arr[0];
}

