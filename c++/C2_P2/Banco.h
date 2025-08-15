#ifndef BANCO_H
#define BANCO_H
#include "Usuario.h"
#include <vector>

class Banco {
private:
    std::vector<std::string> historial;
    std::vector<Usuario*> usuarios;
    Usuario* buscarUsuario(std::string nombre)const;
public:
    Banco();
    ~Banco();
    void agregarUsuario(Usuario* usuario);
    bool transferir(std::string nombreEmisor, std::string nombreReceptor,double monto);
    void mostrarSaldos()const;
    void mostrarHistorial()const;
};



#endif //BANCO_H
