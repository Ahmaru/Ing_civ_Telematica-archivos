#include "polinomio.h"

#include <iostream>
#include <cmath>

Polinomio::Polinomio(std::vector<Termino> terminos_in) : terminos(terminos_in){}

float Polinomio::evaluar(float x){
    float resultado = 0;

    for(size_t i = 0; i < terminos.size(); ++i){
        resultado += terminos[i].coeficiente * std::pow(x, terminos[i].exponente);
    }

    return resultado;
}

int Polinomio::grado(){
    int max_grado = 0;

    for(size_t i = 0; i < terminos.size(); ++i){
        if(terminos[i].exponente > max_grado){
            max_grado = terminos[i].exponente;
        }
    }

    return max_grado;
}

float Polinomio::coeficientePrincipal(){
    float coef = 0;
    int max_grado = grado();

    for(size_t i = 0; i < terminos.size(); ++i){
        if(terminos[i].exponente == max_grado){ 
            coef = terminos[i].coeficiente;
            break;
        }
    }

    return coef;
}

float Polinomio::limite(float x){
    return evaluar(x);
}

Polinomio Polinomio::derivada(){
    std::vector<Termino> terminos_derivados;

    for(size_t i = 0; i < terminos.size(); ++i){
        if(terminos[i].exponente > 0){
            Termino nuevo_termino;
            nuevo_termino.coeficiente = terminos[i].coeficiente * terminos[i].exponente;
            nuevo_termino.exponente = terminos[i].exponente - 1;
            terminos_derivados.push_back(nuevo_termino);
        }
    }

    return Polinomio(terminos_derivados);
}

Polinomio Polinomio::integral(){
    std::vector<Termino> terminos_integrados;

    for(size_t i = 0; i < terminos.size(); ++i){
        Termino nuevo_termino;
        nuevo_termino.coeficiente = terminos[i].coeficiente / (terminos[i].exponente + 1);
        nuevo_termino.exponente = terminos[i].exponente + 1;
        terminos_integrados.push_back(nuevo_termino);
    }
    return Polinomio(terminos_integrados);
}

float Polinomio::integral_def(float a, float b){
    Polinomio integral_pol = integral();

    float valor_a = integral_pol.evaluar(a);
    float valor_b = integral_pol.evaluar(b);

    if(a > b){
        return valor_a - valor_b;
    }

    return valor_b - valor_a;
}

void Polinomio::mostrarPolinomio(){
    for(size_t i = 0; i < terminos.size(); ++i){
        Termino t = terminos[i];

        if(i > 0 && t.coeficiente > 0){
            std::cout << " + ";
        }
        else if(t.coeficiente < 0){
            std::cout << " - ";
        }

        if(std::abs(t.coeficiente) != 1 || t.exponente == 0){
            std::cout << std::abs(t.coeficiente);
        }

        if(t.exponente > 0){
            std::cout << "x";

            if(t.exponente > 1){
                std::cout << "^" << t.exponente;
            }
        }
    }

    std::cout << std::endl;
}

void Polinomio::mostrarPropiedades(){
    std::cout << "Propiedades del Polinomio:\n";
    std::cout << "Grado: " << grado() << "\n";
    std::cout << "Coeficiente principal: " << coeficientePrincipal() << "\n";
}


QString Polinomio::toString() const {
    if (terminos.empty()) {
        return "0"; // Polinomio vacío
    }

    QString resultado;
    for (size_t i = 0; i < terminos.size(); ++i) {
        const auto& termino = terminos[i];

        if (termino.coeficiente == 0) {
            continue; // Ignorar términos con coeficiente 0
        }

        // Agregar signo
        if (i > 0) {
            resultado += (termino.coeficiente > 0 ? " + " : " - ");
        } else if (termino.coeficiente < 0) {
            resultado += "-";
        }

        // Agregar coeficiente (omitimos "1" salvo que sea el término constante)
        if (std::abs(termino.coeficiente) != 1 || termino.exponente == 0) {
            resultado += QString::number(std::abs(termino.coeficiente));
        }

        // Agregar variable y exponente
        if (termino.exponente > 0) {
            resultado += "x";
            if (termino.exponente > 1) {
                resultado += "^" + QString::number(termino.exponente);
            }
        }
    }

    return resultado;
}

