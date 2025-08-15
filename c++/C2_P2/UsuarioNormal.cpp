#include "UsuarioNormal.h"

UsuarioNormal::UsuarioNormal(std::string nombre,double saldo) : Usuario(nombre,saldo){};

UsuarioNormal::~UsuarioNormal(){};

double UsuarioNormal::calcularComision(double monto)const{
    if(this->saldo < monto + monto*0.2){
        std::cout<<"Saldo insuficiente"<<std::endl;
        std::cout<<this->saldo<<monto + monto*0.2<<std::endl;
        return 0;
    }
    return monto + monto*0.2;
}
