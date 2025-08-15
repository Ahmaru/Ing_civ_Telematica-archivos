#include <iostream>

// Estructura para almacenar información de aplicaciones de celulares
struct aplicacion{
    char nombre[100]; // Nombre aplicación
    float version; // Versión en formato flotante (ej. 1.0, 2.4, etc.)
};

// Estructura para almacenar información de cada dispositivo móvil
struct celular{
    char marca[100]; // Marca y modelo del dispositivo móvil
    int n_apps; // Número de aplicaciones que serán instaladas
    aplicacion *apps; // Puntero para almacenar arreglo de aplicaciones instaladas
};

celular registrarTelefono();void instalarApps(celular &cell);void infoCelular(celular cell);

int main(){
    celular Telefonos[2];

    for(int i = 0; i < 2;i++){
        Telefonos[i] = registrarTelefono();

        instalarApps(Telefonos[i]);
    }

    std::cout<<"Informacion de teléfonos registrados: \n"<<std::endl;
    
    for(int i = 0;i<2;i++){
        infoCelular(Telefonos[i]);
    }
    

    return 0;
}

celular registrarTelefono(){
    celular nuevo;

    std::cout<<"Registrando telefono: "<<std::endl;
    std::cout<<"Marca: ";
    std::cin.getline(nuevo.marca,100);

    std::cout<<"Numero de aplicaciones: ";
    std::cin>>nuevo.n_apps;
    std::cin.ignore();
    std::cout<<"\n";


    return nuevo;
}

void instalarApps(celular &cell){
    cell.apps = new aplicacion[cell.n_apps];

    std::cout<<"Instalando apps en "<<cell.marca<<"\n"<<std::endl;

    for(int i = 0; i < cell.n_apps;i++){

        std::cout<<"Ingrese nombre aplicacion: ";
        std::cin.getline(cell.apps[i].nombre,100);


        std::cout<<"Ingrese version aplicacion: ";
        std::cin>>cell.apps[i].version;std::cin.ignore();

        std::cout<<"Aplicacion instalada!\n"<<std::endl   ;

    }
}

void infoCelular(celular cell){
    std::cout<<"Mostrando información celular "<<cell.marca<<std::endl;

    std::cout<<"Cantidad de aplicaciones instaladas: "<<cell.n_apps<<"\n"<<std::endl;

    std::cout<<"Aplicaciones: "<<std::endl;

    for(int i = 0; i< cell.n_apps ; i++){
        std::cout<<"Aplicación "<<cell.apps[i].nombre<<" , versión "<<cell.apps[i].version<<std::endl;
    }

    std::cout<<"\n";
}

