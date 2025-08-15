#include "cuadratica.h"

#include <iostream>
#include <cmath>

Cuadratica::Cuadratica(float a, float b, float c) : Polinomio(std::vector<Termino>{{a, 2}, {b, 1}, {c, 0}}){}

float Cuadratica::calcularVerticeX(){
    float a = coeficientePrincipal(); 
    float b = terminos[1].coeficiente; 
    return -b / (2 * a);
}

float Cuadratica::calcularVerticeY(){
    float x = calcularVerticeX();
    return evaluar(x);
}

float Cuadratica::calcularDiscriminante(){
    float b = terminos[1].coeficiente;
    float a = coeficientePrincipal();
    return (b * b) - (4 * a * terminos[2].coeficiente);
}

Raices Cuadratica::calcularRaices(){
    Raices r;
    float discriminante = calcularDiscriminante();
    float a = coeficientePrincipal();
    float b = terminos[1].coeficiente;

    if(discriminante < 0){
        r.raiz1 = r.raiz2 = NAN; 
    }

    else if(discriminante == 0){
        r.raiz1 = r.raiz2 = -b / (2 * a);
    }

    else{
        // Dos raíces distintas
        r.raiz1 = (-b + sqrt(discriminante)) / (2 * a);
        r.raiz2 = (-b - sqrt(discriminante)) / (2 * a);
    }

    return r;
}

float Cuadratica::evaluar(float x){
    return Polinomio::evaluar(x);
}

std::string Cuadratica::concavidad(){
    return (coeficientePrincipal() > 0) ? "Cóncava hacia arriba" : "Cóncava hacia abajo";
}

float Cuadratica::interceptoY(){
    return terminos[2].coeficiente; 
}

float Cuadratica::calcularEjeSimetria(){
    return calcularVerticeX(); 
}

float Cuadratica::limite(float x){
    return evaluar(x);
}

Polinomio Cuadratica::derivada(){
    return Polinomio::derivada();
}

Polinomio Cuadratica::integral(){
    return Polinomio::integral();
}

float Cuadratica::integral_def(float a, float b){
    return Polinomio::integral_def(a, b);
}

void Cuadratica::mostrarPolinomio(){
    return Polinomio::mostrarPolinomio();
}

void Cuadratica::mostrarPropiedades(){
    std::cout << "Propiedades de la cuadrática:\n";
    std::cout << "Vértice: (" << calcularVerticeX() << ", " << calcularVerticeY() << ")\n";
    std::cout << "Discriminante: " << calcularDiscriminante() << "\n";
    Raices r = calcularRaices();
    std::cout << "Raíz 1: " << (std::isnan(r.raiz1) ? "No hay raíces reales" : std::to_string(r.raiz1)) << "\n";
    std::cout << "Raíz 2: " << (std::isnan(r.raiz2) ? "No hay raíces reales" : std::to_string(r.raiz2)) << "\n";
    std::cout << "Intercepto Y: " << interceptoY() << "\n";
    std::cout << "Eje de Simetría: " << calcularEjeSimetria() << "\n";
    std::cout << "Concavidad: " << concavidad() << "\n";
}

