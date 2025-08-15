#ifndef CUADRATICA_H
#define CUADRATICA_H

#include "polinomio.h"
#include <string>

struct Raices{
    float raiz1;
    float raiz2;
};

class Cuadratica : public Polinomio{
    public:
        Cuadratica(float a, float b, float c);

        float calcularVerticeX();
        float calcularVerticeY();
        float calcularDiscriminante();
        Raices calcularRaices();
        float evaluar(float x);
        std::string concavidad();
        float interceptoY();
        float calcularEjeSimetria();

        float limite(float x);
        Polinomio derivada();
        Polinomio integral();
        float integral_def(float a, float b);

        void mostrarPolinomio();
        void mostrarPropiedades();
};

#endif
