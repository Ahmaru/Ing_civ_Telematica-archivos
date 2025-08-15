#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int verdad = 1;
int mentira = 0;

char* elPalindromoMasLargo(char* s);int DetectarPalindromo(char* s);

int main(){
    char* palabra = (char*)malloc(100*sizeof(char));

    if(palabra == NULL){
        printf("No se ha podido asignar memoria.");
        exit(1);
    }

    printf("Ingrese palabra: ");
    if(fgets(palabra,100,stdin)== NULL){
        printf("Error en la entrada.");
        exit(1);
    }

    palabra[strcspn(palabra,"\n")] = '\0';

    int m = (DetectarPalindromo(palabra)) ? 1 : 0;

    if(m == 1){
        printf("La palabra es palindromo.\n");

    }else if(m == 0){
        printf("La palabra no es palindromo.\n");
    }

    char* palin = elPalindromoMasLargo(palabra);

    printf("El palindromo más largo en la palabra es: %s\n",palin);

    free(palabra);
    free(palin);
    return 0;
}
//Detecta si una frase es palindromo.

int DetectarPalindromo(char* s){
    int porlaizquierda = 0; int porladerecha = strlen(s)-1; 
    
    while(porlaizquierda < porladerecha){
        char izquierdo = s[porlaizquierda];
        char derecho = s[porladerecha];

        //viendo las mayusculas.
        if(izquierdo >= 'A' && izquierdo <= 'Z'){
            izquierdo = izquierdo + ('a' - 'A');
        }    
        if(derecho >= 'A' && derecho <= 'Z'){
            derecho = derecho + ('a' - 'A');
        }

        if(derecho != izquierdo){
            //No es palindromo.
            return 0;
        }

        porlaizquierda++;
        porladerecha--;
    }
    //Detecto palindromo.
    return 1;
}

char* elPalindromoMasLargo(char* s){
    int largo = strlen(s);
    char* palindromo = (char*)malloc((largo + 1)*sizeof(char));
    char* palindromo1 = (char*)malloc((largo + 1)*sizeof(char));

    palindromo1[0] = '\0';
    

    for(int i = 0 ; i < largo ; i++ ){
        int recorredor = 0;
        //printf("el que recorre: %d\n",recorredor);
        
        for(int j = i; j < largo ; j++){
            palindromo1[recorredor] = s[j];
            palindromo1[recorredor + 1] = '\0';
            recorredor++;

            if(DetectarPalindromo(palindromo1)){
                if(strlen(palindromo) <= strlen(palindromo1)){
                    strcpy(palindromo,palindromo1);
                }
            }
        }

    }

    free(palindromo1);
    return palindromo;
}
