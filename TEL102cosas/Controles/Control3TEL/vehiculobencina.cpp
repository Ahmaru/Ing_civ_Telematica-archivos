#include "vehiculobencina.h"
#include <iostream>

void VehiculoBencina::MostrarDetalles(){
    std::cout<<"Vehiculo Bencina: "<<std::endl;
    Vehiculo::MostrarDetalles();
    std::cout<<"Capacidad del estanque \t:"<<this->getBencinaCapacidad()<<std::endl;
    
}