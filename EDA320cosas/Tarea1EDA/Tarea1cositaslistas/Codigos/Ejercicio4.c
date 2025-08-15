#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int es_espacio(char c); int es_vocal(char c); int es_letra(char c); int es_digito(char c);

int contar_vocales(char *cadena); int contar_consonantes(char *cadena); int contar_digitos(char *cadena); 
int contar_caracteres_especiales(char *cadena); int contar_palabras(char *cadena);

int main(){

    char palabras[10000];

    printf("Ingresa palabra: ");

    //esta parte me ayude con gpt para la ayuda en la memoria y evitar algun error al tocar memoria que no se debe.
    if(fgets(palabras, sizeof(palabras),stdin)==NULL){
        printf("Error en la entrada. \n");
        return 1;
    }
    //Esta parte evita los problemas con la ultima parte de ingresar el string por terminal.
    palabras[strcspn(palabras, "\n")] = '\0';

    int N_vocales = contar_vocales(palabras);
    printf("contar_vocales(str) = %d\n",N_vocales);

    int N_letras = contar_consonantes(palabras);
    printf("contar_consonantes(str) = %d\n", N_letras - N_vocales);

    int C_numbers = contar_digitos(palabras);
    printf("contar_digitos(str) = %d\n",C_numbers);

    int Especiales = contar_caracteres_especiales(palabras);
    printf("contar_caracteres_especiales(str) = %d\n",Especiales);

    int Palabras = contar_palabras(palabras);
    printf("contar_palabras(str) = %d\n",Palabras);

    return 0;
}

int es_espacio(char c){
    return c == ' ' || c == '\t' || c == '\n' ;
}
int es_vocal(char c){
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
}
int es_letra(char c){
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}
int es_digito(char c){
    return c >= '0' && c <= '9';
}

int contar_vocales(char *cadena){
    int i = 0;
    int cuentavocale= 0;

    while(cadena[i] != '\0'){
        if(es_vocal(cadena[i])){
            cuentavocale++;
        }
        i++;
    }

    return cuentavocale;
}

int contar_consonantes(char *cadena){

    int i = 0;
    int contarutiles = 0;

    while(cadena[i] != '\0'){
        if(es_letra(cadena[i])){
            contarutiles++;
        }
        i++;
    }    

    return contarutiles;
}

int contar_digitos(char *cadena){
    int i = 0;
    int contardigito = 0;

    while(cadena[i] != '\0'){
        if(es_digito(cadena[i])){
            contardigito++;
        }
        i++;
    }
    return contardigito;
}

int contar_caracteres_especiales(char *cadena){
    int i = 0;
    int y, z, n, m;

    y = contar_consonantes(cadena); z = contar_digitos(cadena);

    //printf("Vocal y consonante %d; digitos %d\n",y,z);

    while(cadena[i] != '\0'){
        if(es_espacio(cadena[i])){
            n++;
        }
        i++;
    }
    //printf("Valor de i %d; espacios %d\n",i,n);

    m = (i  - y - z - n);

    return m;
}

int contar_palabras(char *cadena){
    int i = 0;
    int conteopalabra = 1;

    while(cadena[i] != '\0'){
        if(es_espacio(cadena[i])){
            conteopalabra++;
        }
        i++;
    }
    return conteopalabra;
}
