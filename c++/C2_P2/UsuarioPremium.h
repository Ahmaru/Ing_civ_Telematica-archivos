#ifndef USUARIOPREMIUM_H
#define USUARIOPREMIUM_H
#include "Usuario.h"

//Comision del 2% y verificar si tiene saldo suficiente.

class UsuarioPremium : public Usuario {
public:
UsuarioPremium(std::string nombre, double saldo);
double calcularComision(double monto) const;
};

#endif //USUARIOPREMIUM_H
