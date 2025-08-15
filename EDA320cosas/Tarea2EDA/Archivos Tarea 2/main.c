#include "Prototipos_etc.h"

//Defino el menu en el main porque usare funciones de ambos archivos.
void Menu(nodo_t* cabeza,int dias,int semanas,char** fechas,int Estudiantes);

int main(int argc,char* argv[]){
    nodo_t *inicial = NULL;
    char** fechas = (char**)malloc(5*sizeof(char*));

    char** fechasSincambio = (char**)malloc(5*sizeof(char*));

    int cantfechas = 0;
    int Estudiantes;
    char nombre[100];
    
    FILE *archivo = fopen("Course_List.txt","r");
    if(archivo != NULL){
        
        while(fgets(nombre,sizeof(nombre),archivo)){

            nombre[strcspn(nombre,"\n")] = '\0';

            AñadirEstudiante(&inicial,nombre);
            
        }
        fclose(archivo);
    }else{
        printf("Error al abrir el archivo.\n");
        exit(1);
    }

    Estudiantes = CantidadEstTotales(inicial);

    fechas = GuardarFechas(fechas,&cantfechas);
    fechasSincambio = GuardarFechas(fechasSincambio,&cantfechas);

    int weeks = ((cantfechas/2)+(cantfechas%2));

    CreateSpace(inicial,(cantfechas),weeks);

    AsistenciaDia(inicial,fechas,cantfechas,weeks,Estudiantes);

    Menu(inicial,cantfechas,weeks,fechasSincambio,Estudiantes);

    LiberarMemoria(inicial,fechas,fechasSincambio,cantfechas,weeks);

    free(fechas);
    free(fechasSincambio);

    Vaciar(&inicial);
    free(inicial);

    return 0;
}

void Menu(nodo_t* cabeza,int dias,int semanas,char** fechas,int Estudiantes){
    char Nombre[50];

    while(1){
        char *opcion = (char*)malloc(15*sizeof(char));
        int x = 0;

        printf("Seleccione una opcion: \n1.Cantidad de estudiantes de la EDA. \n2.Buscar estudiante. \n3.Ver asistencia de un estudiante en especifico. \n4.Generar archivo .csv de asistencia. \n5.Ver las estadisticas generales del curso. \n6.Vaciar EDA y cerrar programa. \n");
        printf("Opcion: ");
        scanf("%s",opcion );
        x = atoi(opcion);

        // Limpiar el buffer de entrada para evitar problemas con fgets
        int c;
        while ((c = getchar()) != '\n' && c != EOF) {}

        printf(" \n");

        //system("clear");

        switch (x)
        {
        case 1:
            //Cant Estudiantes totales.
            printf("Estudiantes totales en el curso: %d \n\n",Estudiantes);
            //Menu(cabeza);
            free(opcion);
            break;

        case 2:
            //Posicion de estudiante en EDA
            printf("Ingrese el nombre del Estudiante \n");

            if(fgets(Nombre,sizeof(Nombre),stdin) != NULL){
                Nombre[strcspn(Nombre,"\n")] = '\0';

                int usefull = BuscarEst(cabeza,Nombre);

                printf("\n");
                printf("Posicion en la EDA: %d \n\n",usefull);

            }else{
                printf("Error al recibir por terminal. \n");
                exit(1);
            }

            free(opcion);
            break;

        case 3:
            //Asistencia de estudiante especifico
            printf("Ingrese nombre de estudiante: \n");
            if(fgets(Nombre,sizeof(Nombre),stdin) != NULL){
                Nombre[strcspn(Nombre,"\n")] = '\0';

                printf("\n");
                ShowAttendanceEst(cabeza,Nombre,dias,semanas,fechas);

                printf("\n");

            }else{
                printf("Error al recibir por terminal. \n");
                exit(1);
            }

            free(opcion);
            break;

        case 4:
            //Crear archivo.csv
            
            EscribirCSV(cabeza,dias,fechas);

            free(opcion);
            break;

        case 5:
            //Estadisticas generales del curso.

            free(opcion);
            break;

        case 6:
            //Vaciar EDA y cerrar programa.
            printf("Liberando Memoria y saliendo del programa....\n");
            free(opcion);
            return;

        default:
            printf("Opcion invalida.\n");

            free(opcion);
            break;
        }

    }

}


