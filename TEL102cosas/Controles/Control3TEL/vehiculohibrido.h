#ifndef VEHICULO_HIBRIDO_H
#define VEHICULO_HIBRIDO_H

#include <iostream>
#include "vehiculo.h"

class VehiculoHibrido : public Vehiculo {
    private:
        int CapacidadBateria;
        int CapacidadEstanque;

    public:

        //Constructor
        VehiculoHibrido(std::string marca, std::string modelo, int year,int CapacidadEstaque,int CapacidadBateria) 
        : Vehiculo(marca,modelo,year), CapacidadEstanque(CapacidadEstaque),CapacidadBateria(CapacidadBateria){};

        int getCapacidadBencina(){
            return this->CapacidadEstanque;
        }

        int getCapacidadBateria(){
            return this->CapacidadBateria;
        }        

        void MostrarDetalles() override;
};

#endif