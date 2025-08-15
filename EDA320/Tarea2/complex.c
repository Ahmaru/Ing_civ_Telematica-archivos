#include "discordia.h"

//Funciones para desencriptacion y cosas generales.
//Esperando que ya esta ordenado el arreglo.
void makeppmFinal(pix_t* pixeles,int columna,int filas,char* tamaño,char* tipo,char* maxpix){
    FILE *nuevaimg = fopen("desencriptado.ppm","w");
    if(nuevaimg == NULL){
        printf("Error en la creacion del archivo.\n");
        exit(1);
    }
    
    fprintf(nuevaimg,"%s\n",tipo);
    fprintf(nuevaimg,"%d %d\n",columna,filas);
    fprintf(nuevaimg,"%s\n",maxpix);

    pix_t* rec = pixeles;
    while(rec != NULL){
        fprintf(nuevaimg,"%d %d %d\n",rec->red,rec->green,rec->blue);
        rec = rec->sgte;
    }
    fclose(nuevaimg);
}

void makeppmParcial(pix_t** pixeles,int size,char* tamaño,char* tipo,char* maxpix,int cantpix){
    bool* mostrar = calloc(size, sizeof(bool));
    srand(time(NULL) + rand());

    int seleccionados = 0;
    while (seleccionados < cantpix) {
        int idx = rand() % size;
        if (!mostrar[idx]) {
            mostrar[idx] = true;
            seleccionados++;
        }
    }
    
    FILE *nuevaimg = fopen("desencriptado.ppm","w");
    if(nuevaimg == NULL){
        printf("Error en la creacion del archivo.\n");
        free(mostrar);
        exit(1);
    }
    
    fprintf(nuevaimg,"%s\n",tipo);
    fprintf(nuevaimg,"%s\n",tamaño);
    fprintf(nuevaimg,"%s\n",maxpix);

    for (int i = 0; i < size; i++) {
        if (mostrar[i]) {
            fprintf(nuevaimg, "%d %d %d\n", pixeles[i]->red, pixeles[i]->green, pixeles[i]->blue);
        } else {
            fprintf(nuevaimg, "0 0 0\n");
        }
    }

    fclose(nuevaimg);
    free(mostrar);

}

int verificador(char* intento,char* correct,int tamaño){
    int x = 0,conteo = 0;

    while(x<tamaño){
        if(intento[x] == correct[x]){
            conteo++;
            x++;
        }else{
            x++;
        }
    }
    return conteo;
}

void interno(char* correcta,int size,pix_t* pixelsito, char* tamaño, char* tipo, char* maxpix){
    char palabra[20];
    int intentos = 0;
    pix_t** arr = to_array(pixelsito,size);
    
    printf("Tienes 3 intentos.\nPalabra:");
    for(int i = 0 ; i < size-1 ; i++){
        printf(" _ ");
    }
    printf("\n:");
    
    while(intentos < 3){

        if (intentos == 0) {
            InsertionSortArr(arr,size);
            //RadixSortArr(arr, size);
        } else if (intentos == 1) {
            MergeSortArr(arr, 0, size - 1);
            //RadixSortArr(arr, size);
        } else {
            RadixSortArr(arr, size);
        }

        int pix_a_mostrar = (size / 4) * (intentos + 1); 
        if (pix_a_mostrar > size) pix_a_mostrar = size;

        makeppmParcial(arr, size, tamaño, tipo, maxpix, pix_a_mostrar);
        system("eog desencriptado.ppm &");

        scanf("%s",palabra);
        if(strcmp(palabra,correcta) == 0){
            printf("\n\t\t¡¡¡¡¡¡¡¡Ganaste!!!!!!!\t\t\n");
            free(arr);
            return;
        }else if( verificador(palabra,correcta,size) > 0 && verificador(palabra,correcta,size) < size){
            int n = 0;
            int conta = verificador(palabra,correcta,size);
            printf("Buen intento\nPalabra:");
            while(n<conta){
                if(palabra[n] == correcta[n]){
                    printf(" %c ",correcta[n]);
                    n++;
                }else{
                    printf(" _ ");
                    n++;
                }
            }
            printf("\n");
        }else{
            printf("Intentalo nuevamente\nPalabra:");
            for(int j = 0 ; j < size-1 ; j++){
                printf(" _ ");
            }
            intentos++;
            printf("\n");
        }
    }
    printf("\nHas fallado :[\n");
    free(arr);
}

void menuGame(pix_t** pixeles,pix_t** pixelesCola,char** argumentos,char** listaPalabras,int* tamaños){
    char ImageType[5]; // tipo de imagen que sera adivinada
    int Xeje,Yeje; // matriz de tamaño de imagen Fila x Columna
    char lineaMatriz[15];
    char pixelmaximo[5];
    int size = 0;

    //Como son 8 imagenes pongo el 8 estaticamente siouhgf9seigj.
    int value = SelectIMG((argumentos + 1),8);
    printf("Has seleccionado la imagen %d\n",value);

    FILE* foton = fopen(argumentos[value],"r");
    if(foton == NULL){
        perror("Error en la apertura del archivo.");
        exit(1);
    }

    //Sacando primeras cosas.
    fgets(ImageType,5,foton);
    ImageType[strcspn(ImageType,"\n")] = '\0';
    fgets(lineaMatriz,15,foton);
    lineaMatriz[strcspn(lineaMatriz,"\n")] = '\0';
    fgets(pixelmaximo,5,foton);

    char* tkn = strtok(lineaMatriz," ");
    Xeje = atoi(tkn);
    tkn = strtok(NULL," ");
    Yeje = atoi(tkn);

    char buffer[256];
    while(fgets(buffer,256,foton)){
        buffer[strcspn(buffer,"\n")] = '\0';
        leerArchivo(buffer,pixeles,pixelesCola);
        size++;
    }
    fclose(foton);
    
    interno(listaPalabras[value-1],tamaños[value-1],(*pixeles),lineaMatriz,ImageType,pixelmaximo);
    makeppmFinal((*pixeles),Xeje,Yeje,lineaMatriz,ImageType,pixelmaximo);
}

//Complejidad O(n²) InsertionSort
void InsertionSortArr(pix_t** arr, int size) {
    for (int i = 1; i < size; i++) {
        pix_t* key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j]->id > key->id) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

//Complejidad O(nlogn) MergeSort
void merge(pix_t** arr, int l, int m, int r) {
    int n1 = m - l + 1;
    int n2 = r - m;
    pix_t** L = malloc(n1 * sizeof(pix_t*));
    pix_t** R = malloc(n2 * sizeof(pix_t*));

    for (int i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) {
        if (L[i]->id <= R[j]->id) {
            arr[k++] = L[i++];
        } else {
            arr[k++] = R[j++];
        }
    }
    while (i < n1)
        arr[k++] = L[i++];
    while (j < n2)
        arr[k++] = R[j++];

    free(L);
    free(R);
}

void MergeSortArr(pix_t** arr, int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
        MergeSortArr(arr, l, m);
        MergeSortArr(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}

//Complejidad O(n+d) RadixSort
void RadixSortArr(pix_t** arr, int size) {
    long int max = arr[0]->id;
    for (int i = 1; i < size; i++)
        if (arr[i]->id > max) max = arr[i]->id;

    for (int exp = 1; max / exp > 0; exp *= 10)
        CountingSortArr(arr, size, exp);
}

void CountingSortArr(pix_t** arr, int size, int exp) {
    pix_t** output = malloc(size * sizeof(pix_t*));
    int count[10] = {0};

    // Contar ocurrencias de cada dígito
    for (int i = 0; i < size; i++) {
        int idx = (arr[i]->id / exp) % 10;
        count[idx]++;
    }

    // Sumar acumulativamente
    for (int i = 1; i < 10; i++)
        count[i] += count[i - 1];

    // Construir arreglo de salida (de atrás hacia adelante para estabilidad)
    for (int i = size - 1; i >= 0; i--) {
        int idx = (arr[i]->id / exp) % 10;
        output[count[idx] - 1] = arr[i];
        count[idx]--;
    }

    // Copiar a arr
    for (int i = 0; i < size; i++)
        arr[i] = output[i];

    free(output);
}


long int findMaximum(pix_t* pixeles,int size){
    long int max = pixeles->id;
    pix_t* rec = pixeles;
    while(rec != NULL){
        if(rec->id > max){
            max = rec->id;
        }
        rec = rec->sgte;
    }
    return max;
}
