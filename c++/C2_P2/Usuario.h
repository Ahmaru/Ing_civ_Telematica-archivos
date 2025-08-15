#ifndef USUARIO_H
#define USUARIO_H
#include <iostream>

class Usuario {
protected:
    std::string nombre;
    double saldo;
    static int totalTransaccionesExitosas;
public:
    Usuario(std::string nombre, double saldo_i);
    std::string getNombre() const{ return nombre; }
    double getSaldo() const{ return saldo;}
    static int getTotalTransaccionesExitosas(){return totalTransaccionesExitosas;}
    virtual double calcularComision(double saldo_i) const;
    bool enviarDinero(Usuario *usuario, double monto);
};

#endif //USUARIO_H
