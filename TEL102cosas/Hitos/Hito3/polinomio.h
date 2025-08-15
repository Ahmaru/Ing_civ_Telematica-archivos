#ifndef POLINOMIO_H
#define POLINOMIO_H

#include <vector>
#include <QString>

struct Termino{
    float coeficiente;
    int exponente;
};

class Polinomio{
    protected:
        std::vector<Termino> terminos;

    public:
        Polinomio(std::vector<Termino> terminos_in);

        float evaluar(float x);
        int grado();
        float coeficientePrincipal();

        float limite(float x);
        Polinomio derivada();
        Polinomio integral();
        float integral_def(float a, float b);

        void mostrarPolinomio();
        void mostrarPropiedades();

        QString toString() const;
};

#endif
