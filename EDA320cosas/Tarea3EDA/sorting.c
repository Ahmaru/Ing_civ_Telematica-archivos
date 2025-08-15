#include "Funciones.h"


//Funciones generales.

void imprimir(int *p, int length){
    printf("{");
    for(int i = 0 ; i < length ; i++ ){
        if(i == (length -1 )){
            printf(" %d ",p[i]);
            break;
        }
        printf(" %d, ",(p[i]));
    }
    printf("}\n");

}

int power(int base , int potencia){
    int potenciado = 1;

    if(potencia == 0){
        return 1;
    }

    for(int i = 0 ; i < potencia ; i++){
        potenciado *= base;
    }

    return potenciado;

}


int GenerarNumRandom(){
    int max = 500000000;
    int min = -500000000;

    int number = min + rand() % (max - min + 1);

    return number;

}

void AsignarNMBR(int* arreglo,int largo){

    for(int i = 0 ; i < largo ; i++ ){
        arreglo[i] = GenerarNumRandom();
        //printf(" %d .",arreglo[i]);
    }

    //printf("\n");
}


void LLenarstruct(sort* ordenable,double Time_n2 , double Time_nlogn , double Time_lineal ){
    char* nombres[3] = {"Selection Sort","Merge Sort","Radix Sort"};

    if(Time_n2 < Time_lineal && Time_n2 < Time_nlogn && Time_lineal < Time_nlogn){
        ordenable[0].nombre = nombres[0];
        ordenable[0].tiempo = Time_n2;

        ordenable[1].nombre = nombres[2];
        ordenable[1].tiempo = Time_lineal;

        ordenable[2].nombre = nombres[1];
        ordenable[2].tiempo = Time_nlogn;

    }else if(Time_n2 < Time_lineal && Time_n2 < Time_nlogn && Time_lineal > Time_nlogn){

        ordenable[0].nombre = nombres[0];
        ordenable[0].tiempo = Time_n2;

        ordenable[1].nombre = nombres[1];
        ordenable[1].tiempo = Time_nlogn;

        ordenable[2].nombre = nombres[2];
        ordenable[2].tiempo = Time_lineal;


    }else if (Time_nlogn < Time_lineal && Time_nlogn < Time_n2  && Time_lineal < Time_n2){

        ordenable[0].nombre = nombres[1];
        ordenable[0].tiempo = Time_nlogn;

        ordenable[1].nombre = nombres[2];
        ordenable[1].tiempo = Time_lineal;

        ordenable[2].nombre = nombres[0];
        ordenable[2].tiempo = Time_n2;

    }else{

        ordenable[0].nombre = nombres[2];
        ordenable[0].tiempo = Time_lineal;

        ordenable[1].nombre = nombres[1];
        ordenable[1].tiempo = Time_nlogn;

        ordenable[2].nombre = nombres[0];
        ordenable[2].tiempo = Time_n2;

    }

    //free(nombres);

}


void WriteCSV(double Time_n2 , double Time_nlogn , double Time_lineal , int* array , int largo, int* arrayordenado){
    FILE* archivo = fopen("Complexity.csv","w");
    if(archivo == NULL){
        printf("Error al crear archivo.\n");
        exit(1);
    }

    sort* complex = (sort*)malloc(3*sizeof(sort));

    LLenarstruct(complex,Time_n2,Time_nlogn,Time_lineal);

    fprintf(archivo,"Nombre algoritmo ; Tiempo en segundos \n");

    for(int x = 0 ; x < 3 ; x++){
        fprintf(archivo,"%s ; %3lf \n",complex[x].nombre,complex[x].tiempo);
    }

    fprintf(archivo,"\nDatos totales : %d \nArreglo sin orden: \n{",largo);


    for(int i = 0 ; i < largo ; i++ ){
        if(i == largo - 1){
            fprintf(archivo," %d }\n",array[i]);
            break;
        }
        
        fprintf(archivo," %d ;",array[i]);
    }

    fprintf(archivo,"\nArreglo ordenado: \n{");

    for(int j = 0 ; j < largo ; j++){
        if(j == largo - 1){
            fprintf(archivo," %d }\n",arrayordenado[j]);
            break;
        }

        fprintf(archivo," %d ;",arrayordenado[j]);

    }  

    free(complex);
    fclose(archivo);
}

void CreateSPCEarray(int* entrada, int* copia,int largo){
    for(int i = 0 ; i < largo ; i++){
        copia[i] = entrada[i];
    }

}


void menuLindo(int* array , int tamano){
    double Time_n2;
    double Time_nlogn;
    double Time_lineal;
    int* arreglo1 = (int*)malloc(tamano * sizeof(int));
    int* arreglo2 = (int*)malloc(tamano * sizeof(int));
    int* arreglo3 = (int*)malloc(tamano * sizeof(int));
    if(arreglo1 == NULL || arreglo2 == NULL || arreglo3 == NULL){
        printf("Error al asignar memoria.\n");
        exit(1);
    }


    CreateSPCEarray(array,arreglo1,tamano);
    CreateSPCEarray(array,arreglo2,tamano);
    CreateSPCEarray(array,arreglo3,tamano); 


    while(1){
        int opcion;
        char *option = (char*)malloc(10*sizeof(char));

        printf("Seleccione el algoritmo a probar: \n(1)Selection Sort \n(2)Merge Sort \n(3)Radix Sort \n(4)Generar archivo y cerrar \nOpcion: ");
        scanf("%s",option);
        opcion = atoi(option);


        //Limpiar buffer.
        int c;
        while((c = getchar()) != '\n' && c != EOF){}

        switch(opcion){
            case 1 : 
                printf("Cargando...\n");

                clock_t inicio = clock();

                SelectionSort(arreglo1,tamano);

                clock_t finale = clock();

                Time_n2 = ((double)(finale - inicio)) / CLOCKS_PER_SEC;
                printf("End.\n");
                free(arreglo1);
                free(option);

                break;

            case 2 :
                printf("Cargando...\n");

                clock_t init = clock();

                MergeSort(arreglo2,0,tamano - 1);

                clock_t end = clock();

                Time_nlogn = ((double)(end - init)) / CLOCKS_PER_SEC;

                free(option);
                free(arreglo2);
                break;

            case 3 : 
                printf("Cargando...\n");

                clock_t empezar = clock();

                RadixSort(arreglo3,tamano);

                clock_t final = clock();

                Time_lineal = ((double)(final - empezar)) / CLOCKS_PER_SEC;

                free(option);
                break;

            case 4 :
                printf("Generando...\n");

                WriteCSV(Time_n2,Time_nlogn,Time_lineal,array,tamano,arreglo3);

                printf("Cerrando programa....\n");
                free(arreglo3);
                free(option);

                return;


            default : 
                printf("Opcion no reconocida.\n Intente nuevamente.\n");
                break;

        }
    }

}


//Funciones SELECTIONSORT

void swap(int *a , int *b){
    int temp = *a;
    *a = *b;
    *b = temp;

}

void SelectionSort(int* p, int length){
    for(int i = 0 ; i < length - 1 ; i++ ){
        int Index = i;

        for(int j = i + 1 ; j < length ; j++ ){
            //printf("i:%d \nj:%d \n",i,j);

            if(p[j] < p[Index]){
                Index = j;
            }
        }

        if(p[i] > p[Index]){
            swap(&p[i],&p[Index]);
        }
    }
}

/*Funciones MERGESORT*/

//MERGESORT

void Merge(int* array, int izq , int medio , int der){
    int lengthL = medio - izq + 1 ;
    int lengthR = der - medio;

    //Arreglos temporales"
    int *left = (int*)malloc(lengthL * sizeof(int));
    if(left == NULL){
        printf("Error al asignar memoria.\n");
        exit(1);
    }

    int *rigth = (int*)malloc(lengthR* sizeof(int));
    if(rigth == NULL){
        printf("Error al asignar memoria.\n");
        exit(1);
    }



    for(int i = 0 ; i < lengthL ; i++){
        left[i] = array[izq + i];
    }
    for(int j = 0 ; j < lengthR ; j++ ){
        rigth[j] = array[medio + 1 + j];
    }

    int x = 0 ; 
    int y = 0 ; 
    int k = izq;

    //juntando arreglos.

    while( x < lengthL && y < lengthR ){
        if(left[x] <= rigth[y]){
            array[k] = left[x];
            x++;
        }else{
            array[k] = rigth[y];
            x++;
        }

        k++;
    }

    while(x<lengthL){
        array[k] = left[x];
        x++;
        k++;
    }

    while(y<lengthR){
        array[k] = rigth[y];
        y++;
        k++;
    }

    free(left);
    free(rigth);

}


void MergeSort(int* array, int izq , int der){
    if(izq < der){
        int mid = izq + (der - izq) / 2;
        //printf("prueba: %d\n%d\n%d\n",izq,mid,der);

        MergeSort(array, izq , mid);
        MergeSort(array, mid+1 , der);


        //En teoria XD.
        Merge(array,izq,mid,der);

    }
}


//Funciones COUNTINGSORT.

void FindMAX_MIN(int* array , int largo , int* max , int* min){
    *max = array[0]; *min = array[0];

    for(int i = 0 ; i < largo ; i++ ){
        if(array[i] > *max ){
            *max = array[i];
        }
        if(array[i] < *min){
            *min = array[i];
        }
    } 
}

int* ManejarArreglosAX(int* auxrray ,int largocount){
    auxrray = (int*)calloc(largocount,sizeof(int));

    return auxrray;
}

void CountingSort(int* array , int largo , int lugar){
    //int max , min;
    
    //FindMAX_MIN(array,largo,&max,&min);

    //El valor ignorando los negativos, es decir los valores que puede tomar de [-9,9].
    int counting = 19;

    int* counting_array = NULL; 
    counting_array = ManejarArreglosAX(counting_array,counting);

    //Desplazamiento del array para trabajar con positivos teniendo que no sale del [-9,9].
    int desplazamiento = 9;

    // Contando ocurrencias de digitos.
    for (int i = 0; i < largo; i++) {
        int digitoUtil = (array[i] / lugar) % 10; 
        counting_array[digitoUtil + desplazamiento]++;
    }

    //Convertir las ocurrencias en posiciones.
    for (int j = 1; j < counting; j++) {
        counting_array[j] += counting_array[j - 1];
    }

    //Ordenar los elementos del arreglo.
    int* sorted_array = (int*)malloc(largo * sizeof(int));
    for (int i = largo - 1; i >= 0; i--) {
        int digitoUtil = (array[i] / lugar) % 10;
        int pos = counting_array[digitoUtil + desplazamiento] - 1;
        sorted_array[pos] = array[i];
        counting_array[digitoUtil + desplazamiento]--;
    }


    for (int i = 0; i < largo; i++) {
        array[i] = sorted_array[i];
    }


    free(sorted_array);
    free(counting_array);

}

//Funciones RADIXSORT.

int maximo(int* array , int largo){
    int max = array[0];

    for(int i = 0 ; i < largo ; i++ ){
        if(array[i] > max)
            max = array[i];
    }

    return max;

}

void RadixSort(int* array, int size){
    int posicion;
    int max = maximo(array,size);

    for(posicion = 0 ; (max/power(10,posicion)) > 0 ; posicion++ ){
        CountingSort(array,size,(power(10,posicion)));
    }

}

