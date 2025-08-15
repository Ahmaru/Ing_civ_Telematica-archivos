#ifndef VEHICULO_H
#define VEHIVULO_H

#include <iostream>
#include <string>

class Vehiculo {
    protected:
        std::string marca;
        std::string modelo;
        int añodefabricacion;

    public:

        //constructor
        Vehiculo(std::string marca , std::string modelo, int año){
            this->marca = marca;
            this->modelo = modelo;
            this->añodefabricacion = año;
        }

        //destructor
        ~Vehiculo(){};

        std::string getMarca(){
            return this->marca;
        }

        std::string getModelo(){
            return this->modelo;
        }

        int getYear(){
            return this->añodefabricacion;
        }

        //virtual
        virtual void MostrarDetalles() = 0;

};


#endif