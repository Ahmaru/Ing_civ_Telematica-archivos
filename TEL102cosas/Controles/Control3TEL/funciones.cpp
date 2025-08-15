#include "funciones.h"
#include <iostream>
#include <string>

void registrarVehiculo(std::vector<Vehiculo*>& flota){
    int CantVehiculos;
    std::cout<<"Cuantos vehiculos desea registrar: ";
    std::cin>>CantVehiculos;
    std::cin.ignore();

    int opcion;
    std::cout<<"Registrar vehiculo: "<<std::endl;
    std::cout<<"Que tipo de vehiculo desea registrar:\n (1)Bencinero , (2)Electrico , (3)Hibrido\nOpcion";
    std::cin>>opcion;
    std::cin.ignore();

    for(int i = 0 ; i <= CantVehiculos ; i++ ){
        if(opcion == 1){
            std::string Marc;
            std::string Model;
            int year;
            int capacity;

            std::cout<<"Ingrese la Marca: ";
            std::getline(std::cin,Marc);
            std::cin.ignore();

            std::cout<<"Ingrese el modelo: ";
            std::getline(std::cin,Model);
            std::cin.ignore();

            std::cout<<"Ingrese el año de fabricacion: ";
            std::cin>>year;
            std::cin.ignore();

            std::cout<<"Ingrese capacidad del estanque: ";
            std::cin>>capacity;
            std::cin.ignore();

            flota[i] = new VehiculoBencina(Marc,Model,year,capacity);

        }else if(opcion == 2){
            std::string Marc;
            std::string Model;
            int year;
            int capacity;

            std::cout<<"Ingrese la Marca: ";
            std::getline(std::cin,Marc);
            std::cin.ignore();

            std::cout<<"Ingrese el modelo: ";
            std::getline(std::cin,Model);
            std::cin.ignore();

            std::cout<<"Ingrese el año de fabricacion: ";
            std::cin>>year;
            std::cin.ignore();

            std::cout<<"Ingrese capacidad de la bateria: ";
            std::cin>>capacity;
            std::cin.ignore();

            flota[i] = new VehiculoElectrico(Marc,Model,year,capacity);

        }else if(opcion == 3){
            std::string Marc;
            std::string Model;
            int year;
            int capacityB;
            int capacityE;


            std::cout<<"Ingrese la Marca: ";
            std::getline(std::cin,Marc);
            std::cin.ignore();

            std::cout<<"Ingrese el modelo: ";
            std::getline(std::cin,Model);
            std::cin.ignore();

            std::cout<<"Ingrese el año de fabricacion: ";
            std::cin>>year;
            std::cin.ignore();

            std::cout<<"Ingrese capacidad de la bateria: ";
            std::cin>>capacityB;
            std::cin.ignore();

            std::cout<<"Ingrese capacidad del estanque: ";
            std::cin>>capacityE;
            std::cin.ignore();

            flota[i] = new VehiculoHibrido(Marc,Model,year,capacityE,capacityB);

        }else{
            std::cout<<"Opcion no identificada..\nSaliendo del programa."<<std::endl;
            return;
        }
    }
}

void mostrarFlota(const std::vector<Vehiculo*>& flota){
    for(size_t i = 0 ; i < flota.size() ; i++ ){
        flota[i]->MostrarDetalles();
    }
}

void liberarFlota(std::vector<Vehiculo*>& flota){
    for(size_t i = 0 ; i < flota.size() ; i++ ){
        delete flota[i];
    }

    flota.clear();
    std::cout<<"Se ha libera la flota."<<std::endl;
    
}
