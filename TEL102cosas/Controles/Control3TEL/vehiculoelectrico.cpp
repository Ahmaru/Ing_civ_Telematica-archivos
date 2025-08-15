#include "vehiculoelectrico.h"
#include <iostream>

void VehiculoElectrico::MostrarDetalles(){
    std::cout<<"Vehiculo Electrico: "<<std::endl;
    Vehiculo::MostrarDetalles();
    std::cout<<"Capacidad de la bateria \t:"<<this->getCapacidadBateria()<<std::endl;
    
}