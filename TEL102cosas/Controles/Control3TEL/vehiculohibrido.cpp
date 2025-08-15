#include "vehiculohibrido.h"
#include <iostream>

void VehiculoHibrido::MostrarDetalles(){
    std::cout<<"Vehiculo Hibrido: "<<std::endl;
    Vehiculo::MostrarDetalles();
    std::cout<<"Capacidad de la bateria \t:"<<this->getCapacidadBateria()<<std::endl;
    std::cout<<"Capacidad del estanque \t :"<<this->getCapacidadBencina()<<std::endl;
    
}