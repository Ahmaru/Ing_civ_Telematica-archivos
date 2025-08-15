#ifndef VEHICULO_BENCINA_H
#define VEHICULO_BENCINA_H

#include <iostream>
#include "vehiculo.h"

class VehiculoBencina : public Vehiculo {
    private:
        int CapacidadEstanque;

    public:

        //Constructor
        VehiculoBencina(std::string marca, std::string modelo, int year,int CapacidadEstaque) 
        : Vehiculo(marca,modelo,year), CapacidadEstanque(CapacidadEstaque){};

        int getBencinaCapacidad(){
            return this->CapacidadEstanque;
        }        

        void MostrarDetalles() override;
};

#endif