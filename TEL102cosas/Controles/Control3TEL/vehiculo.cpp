#include "vehiculo.h"
#include <iostream>


void Vehiculo::MostrarDetalles(){
    std::cout<<"Especificaciones del vehiculo:"<<std::endl;
    std::cout<<"Marca\t\t :"<<Vehiculo::getMarca()<<std::endl;
    std::cout<<"Modelo\t\t:"<<Vehiculo::getModelo()<<std::endl;
    std::cout<<"Año de fabricacion\t:"<<Vehiculo::getYear()<<std::endl;
    
}
