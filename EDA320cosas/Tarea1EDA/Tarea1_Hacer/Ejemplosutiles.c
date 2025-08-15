#include <stdio.h>
#include <string.h>

int main() {
    char input[100]; // Donde se almacenará la cadena ingresada por el usuario
    char *token;     // Para almacenar cada parte separada
    const char delimitador[2] = ",";  // Definir la coma como delimitador

    // Pedir al usuario que ingrese una cadena con comas
    printf("Ingresa una cadena de palabras separadas por comas: ");
    fgets(input, sizeof(input), stdin);  // Leer la entrada del usuario

    // Eliminar el salto de línea que fgets puede agregar
    input[strcspn(input, "\n")] = '\0';

    // Obtener el primer token (la primera palabra antes de la coma)
    token = strtok(input, delimitador);

    // Mientras haya tokens, sigue imprimiendo o almacenando
    while (token != NULL) {
        printf("Palabra separada: %s\n", token);  // Aquí podrías almacenar el token en una variable
        token = strtok(NULL, delimitador);  // Obtener el siguiente token
    }

    return 0;
}