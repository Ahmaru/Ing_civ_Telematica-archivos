#include "Usuario.h"

Usuario::Usuario(std::string nombre,double saldo){
     this->nombre = nombre;
     this->saldo = saldo;
}

bool Usuario::enviarDinero(Usuario* usuario,double monto){
     if(this->nombre != usuario->getNombre()){
          if(calcularComision(monto) == 0){return false;}
          this->saldo -= calcularComision(monto);
          return true;
     }
     return false;
}
