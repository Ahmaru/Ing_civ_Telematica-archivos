#include "Banco.h"

Banco::Banco(){}

Banco::~Banco(){}

void Banco::agregarUsuario(Usuario* user){
    this->usuarios.push_back(user);
}

Usuario* Banco::buscarUsuario(std::string nombre)const{
    int i = 0;
    while(!this->usuarios.empty()){
        if(this->usuarios.at(i)->getNombre() == nombre){
            return this->usuarios.at(i);
        }
        i++;
    }
    return nullptr;
}

bool Banco::transferir(std::string nombreEmisor, std::string nombreReceptor,double monto){
    Usuario *emiter = buscarUsuario(nombreEmisor);
    Usuario *receptor = buscarUsuario(nombreReceptor);
    std::string mensaje = emiter->getNombre() + "envio $" + std::to_string(monto) + "a " + receptor->getNombre();

    if(emiter->enviarDinero(receptor,monto)){
        this->historial.push_back(mensaje);
        std::cout<<"Transferencia exitosa.";
    }

}

void Banco::mostrarSaldos()const{
    std::cout<<"------Saldos------"<<std::endl;
    for(int i = 0 ; i < this->usuarios.size() ; i++){
        std::cout<<this->usuarios.at(i)->getNombre() << ":" << "$"<<this->usuarios.at(i)->getSaldo()<<std::endl;
    }
}

void Banco::mostrarHistorial()const{
    std::cout<<"------Historial------"<<std::endl;

    for(int i = 0; i < this->historial.size();i++){
        std::cout<<this->historial.at(i)<<std::endl;
    }

}
