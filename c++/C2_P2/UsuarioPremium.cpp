#include "UsuarioPremium.h"

UsuarioPremium::UsuarioPremium(std::string nombre,double saldo) : Usuario(nombre,saldo){}

double UsuarioPremium::calcularComision(double monto)const{
    if(this->saldo < monto){
        std::cout<<"Saldo es insuficiente."<<std::endl;
        std::cout<<"Saldo actual: "<<this->saldo;
        return 0;
    }
    //this->saldo = this->saldo-monto;
    std::cout<<"Transferencia correcta."<<std::endl;
    return monto;
}
