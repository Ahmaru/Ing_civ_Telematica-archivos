#include <iostream>
#include "Funciones.hpp"

int main(){

    float a, b, c;

    do{

        std::cout << "Introduce el coeficiente de x² (a): ";
        std::cin >> a;

        if(a == 0){
            std::cout << "Esa no sería una función cuadrática, intenta con otro valor" << std::endl;
        }

    } while (a == 0);


    std::cout << "Introduce el coeficiente de x (b): ";
    std::cin >> b;

    std::cout << "Introduce el coeficiente c: ";
    std::cin >> c;

    MenuInteractivo(a, b, c);

    return 0;
}