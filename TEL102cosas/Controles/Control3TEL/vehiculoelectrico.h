#ifndef VEHICULO_ELECTRICO_H
#define VEHICULO_ELECTRICO_H

#include <iostream>
#include "vehiculo.h"

class VehiculoElectrico : public Vehiculo {
    private:
        int CapacidadBateria;

    public:

        //Constructor
        VehiculoElectrico(std::string marca, std::string modelo, int year,int CapacidadBateria) 
        : Vehiculo(marca,modelo,year), CapacidadBateria(CapacidadBateria){};

        int getCapacidadBateria(){
            return this->CapacidadBateria;
        }        

        void MostrarDetalles() override;
};

#endif