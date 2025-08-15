#include <stdio.h>
#include <stdlib.h>

void merge(int* array , int izq , int mid , int der );

void mergeSort(int* array, int izq , int der);

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

int main(){

    int arr[] = {38, 27, 43, 3, 9, 82, 10};
    int size = sizeof(arr) / sizeof(arr[0]);

    printf("Arreglo original: ");
    printArray(arr, size);

    mergeSort(arr, 0, size - 1);

    printf("Arreglo ordenado: ");
    printArray(arr, size);
    return 0;

    return 0;
}

void merge(int* array , int izq , int mid , int der ){
    int n1 = mid - izq + 1;
    int n2 = der - mid;
    
    int L[n1], R[n2];  // Arreglos temporales para almacenar las mitades

    // Copiamos los datos a los arreglos temporales L[] y R[]
    for (int i = 0; i < n1; i++)
        L[i] = array[izq + i];
    for (int j = 0; j < n2; j++)
        R[j] = array[mid + 1 + j];

    int i = 0, j = 0, k = izq;

    // Fusionamos los arreglos L y R de forma ordenada en arr[]
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            array[k] = L[i];
            i++;
        } else {
            array[k] = R[j];
            j++;
        }
        k++;
    }

    // Copiamos los elementos restantes de L[], si hay alguno
    while (i < n1) {
        array[k] = L[i];
        i++;
        k++;
    }

    // Copiamos los elementos restantes de R[], si hay alguno
    while (j < n2) {
        array[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int* array, int izq , int der){
    int middle = izq + (der - izq) / 2;

    if(izq < der ){
        mergeSort(array , izq , middle);
        mergeSort(array , middle+1 , der);

        merge(array,izq,middle,der);
    }
}
