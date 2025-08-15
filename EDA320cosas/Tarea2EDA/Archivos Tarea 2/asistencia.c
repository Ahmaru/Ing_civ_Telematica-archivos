#include <stdio.h>
#include "Prototipos_etc.h"


void AñadirEstudiante(nodo_t **cabeza,char *name){
    nodo_t *nuevo = malloc(sizeof(nodo_t));
    if(nuevo == NULL){
        printf("Error al asignar memoria.");
        return;
    }

    nuevo->nombre = (char*)malloc((strlen(name)+1)*sizeof(char));
    if(nuevo->nombre == NULL){
        printf("Error al asignar memoria.");
        return;
    }

    //printf("1");
    strcpy(nuevo->nombre,name);

    nuevo->sgte = NULL;
    nuevo->prev = NULL;

    if((*cabeza) == NULL){
        (*cabeza) = nuevo;

    }else{
        nodo_t *recorredor = (*cabeza);

        while(recorredor->sgte != NULL){
            recorredor = recorredor->sgte;
        }

        recorredor->sgte = nuevo;
        nuevo->prev = recorredor;


    }
}


//esta funcion me crea espacio dinamicamente para la lista de asistencia.
void CreateSpace(nodo_t* cabeza,int days,int semanas){ 
    nodo_t* recorredor = cabeza;

    
    while(recorredor != NULL){
        recorredor->asistencia_semanal = (int**)malloc((semanas+1)*(sizeof(int*)));
        if(recorredor->asistencia_semanal == NULL){
            printf("Error al asignar memoria. \n");
            exit(1);
        }
        recorredor = recorredor->sgte;
    }

    recorredor = cabeza;
    //int i = 0;
    while(recorredor != NULL){
        for(int i = 0 ; i < (semanas +1) ; i++){
            recorredor->asistencia_semanal[i] = (int*)calloc(2,sizeof(int));
            if(recorredor->asistencia_semanal[i] == NULL){
                printf("Error al asignar memoria. \n");
                exit(1);
            }
        
        }
        recorredor = recorredor->sgte;
    }


}


char** GuardarFechas(char** array, int* cantF){
    FILE* archivo = fopen("Course_Dates.txt","r");
    if(archivo == NULL){
        printf("No se pudo abrir el archivo.\n");
        exit(1);
    }

    char Use[25];
    int capacidad = 5;
    int length = 25;
    int i = 0;


    while(fgets(Use,length,archivo)){

        Use[strcspn(Use,"\n")] = '\0';

        if((i+1) == capacidad){
            capacidad = (capacidad + 5);
            array = (char**)realloc(array,capacidad * sizeof(char*));
            if(array == NULL){
                printf("Error al asignar memoria.\n");
                exit(1);
            }
        }

        
        array[i] = (char*)malloc(length * sizeof(char));
        if(array[i] == NULL){
            printf("Error al asignar memoria.\n");
            exit(1);
        }
        
        strcpy(array[i],Use);
        i++;

    }
    
    fclose(archivo);

    (*cantF) = i;

    return array;
}

//Esta funcion es muy especifica para este caso ya que al hacerlo supuse que el formato fecha MM-DD-AAAA se mantiene.
char* agregarTXT(char* FechaInteres){
    if(FechaInteres == NULL){
        printf("Error al reasginar memoria.");
        exit(1);
    }

    //printf("%s\n",FechaInteres);

    const char* agregar = ".txt";
    int i = 0;

    
    while(FechaInteres[i] != '\0'){
        //printf("Pos[%d]: %c",i,FechaInteres[i]);
        //printf("%d\n",i);
        i++;
    }
    
    //printf("%d\n",i);
    FechaInteres[10] = agregar[0];
    FechaInteres[11] = agregar[1];
    FechaInteres[12] = agregar[2];
    FechaInteres[13] = agregar[3];
    FechaInteres[14] = '\0';

    //printf("%s\n",FechaInteres);

    return FechaInteres;
}

int comparar(char* COMP1 , char* COMP2){

    int First = strlen(COMP1);
    //int Scond = strlen(COMP2);

    int i = 0;
    while(1){
        if(COMP1[i] != COMP2[i]){
            //printf("No \n");
            break;
        }else{
            i++;
        }
    }

    if(i == First){
        return (i+1);
    }else{
        return 0;
    }

}


//Funcion que pasa la asistencia de cada alumno.
void AsistenciaDia(nodo_t* cabeza,char** filename,int days ,int weeks, int EstudiantesEDA){
    int i = 0;
    int WeelyUse;

    while(i<days){

        filename[i] = agregarTXT(filename[i]);

        FILE* archivo = fopen(filename[i],"r");
        if(archivo == NULL){
            printf("No se pudo abrir el archivo.\n");
            exit(1);
        }

        int j = 0;
        char NombreUsar[EstudiantesEDA][50];

        while(fgets(NombreUsar[j],50,archivo)){
            NombreUsar[j][strcspn(NombreUsar[j],"\n")] = '\0';
            j++;
        }
        fclose(archivo);


        nodo_t* recorre = cabeza;
        int x = 0;

        WeelyUse = ((i/2)+(i%2));

        while(recorre != NULL && x<j){


            if(strcmp(recorre->nombre,NombreUsar[x]) != 0){
                recorre = recorre->sgte;
            }else{
                recorre->asistencia_semanal[WeelyUse][(i%2)] = asistio;
                x++;
            }
        }

        i++;
    }


}


int CantidadEstTotales(nodo_t* cabeza){
    int EstTot = 0;
    nodo_t* recorredor = cabeza;
    
    while(recorredor != NULL){
        recorredor = recorredor->sgte;
        EstTot++;
    }

    return EstTot;
}



//funcion para buscar la pocision del estudiante a ver asistencia o estadisticas generales.
int BuscarEst(nodo_t* cabeza,char* Nombrebusqueda){
    nodo_t* recorredor = cabeza;
    int i = 0;

    while(recorredor != NULL){
        if(comparar(Nombrebusqueda,recorredor->nombre) == 0){
            //printf("%d \n %s \n",(i+1),recorredor->nombre);
            recorredor = recorredor->sgte;
            i++;
        }else{
            //printf("%s \n",recorredor->nombre);
            return (i+1);
        }

    }

    return i;
}

void ShowAttendanceEst(nodo_t *cabeza,char* NomInteres,int dias, int semanas , char** fechas){
    nodo_t *recorredor = cabeza;
    

    while(recorredor != NULL){
        if(comparar(NomInteres,recorredor->nombre) == 0){
            recorredor = recorredor->sgte;
        }else{
            break;
        }
    }

    if(recorredor == NULL){
        printf("No se encontro el nombre. \n");
    }

    printf("Asistencia por dia de : %s \n\n",recorredor->nombre);

    for(int i = 0 ; i < (dias+1) ; i++){
        printf("%d :",i);
        printf("%d \n",recorredor->asistencia_semanal[((i/2)+(i%2))][(i%2)]);
    }

}



//funcion para liberar memoria de los int, los char y strings.
void LiberarMemoria(nodo_t* cabeza,char** arrays,char** array2,int dias, int Semanas){
    nodo_t* recorreN = cabeza;
    nodo_t* recorreI = cabeza;

    while(recorreN != NULL){
        free(recorreN->nombre);
        recorreN = recorreN->sgte;
    }


    while (recorreI != NULL) {
        for (int i = 0; i < (Semanas+1) ; i++) {
            free(recorreI->asistencia_semanal[i]); 
        }
        free(recorreI->asistencia_semanal);  
        recorreI = recorreI->sgte;  
    }

    for(int j = 0 ; j < dias ; j++){
        if(arrays[j] != NULL){
            free(arrays[j]);
        }
    }

    for(int j = 0 ; j < dias ; j++){
        if(array2[j] != NULL){
            free(array2[j]);
        }
    }

}

void Vaciar(nodo_t** cabeza){

    while((*cabeza) != NULL){
        nodo_t* recorredor = (*cabeza);
        (*cabeza) = (*cabeza)->sgte;

        free(recorredor);

    }
    printf("Se ha liberado la EDA\n");

}


