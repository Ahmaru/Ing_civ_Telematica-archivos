#include <stdio.h>
#include "Prototipos_etc.h"

void EscribirCSV(nodo_t* cabezal,int dias,char** fechas){

    FILE* archivo = fopen("Course_Attendance.csv","w");

    if(archivo == NULL){
        printf("No se pudo crear archivo. \n");
        exit(1);
    }

    fprintf(archivo, "Nombre;");
    for (int i = 0; i < dias; i++){
        eliminarSaltoDeLinea(fechas[i]);
        fprintf(archivo, "%s", fechas[i]);
        if (i < dias - 1) {
            fprintf(archivo, ";");  // Evitamos el ";" final
        }
    }
    fprintf(archivo, "\n");

    nodo_t* recorre = cabezal;

    while(recorre != NULL){

        fprintf(archivo, "%s;",recorre->nombre);
        eliminarSaltoDeLinea(recorre->nombre);

        int j = 0;
        while(j < dias){
            int week = (j/2);
            int Dialindo = (j%2);

            fprintf(archivo, "%d",recorre->asistencia_semanal[week][Dialindo]);

            if(j < dias - 1){
                fprintf(archivo,";");
            }
            j++;
        }
        fprintf(archivo, "\n");
        recorre = recorre->sgte;
    }

    fclose(archivo);
}

void eliminarSaltoDeLinea(char* str){
    size_t len = strlen(str);
    for(int i = 0 ; i < len ; i++){
        if(str[i] == '\n' && len > 0){
            str[i] = '\0';
        }
    }
}
