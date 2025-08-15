#ifndef USUARIONORMAL_H
#define USUARIONORMAL_H
#include "Usuario.h"

class UsuarioNormal : public Usuario {
public:
    UsuarioNormal(std::string nombre,double saldo);
    double calcularComision(double monto)const;
};



#endif //USUARIONORMAL_H
