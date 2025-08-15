#include "funciones.h"

#include <iostream>

Cuadratica* crearPolinomioCuadratico(){
    float a, b, c;

    while(true){
        std::cout << "Ingrese el coeficiente a (diferente de 0): ";
        std::cin >> a;

        if(std::cin.fail() || a == 0){ 
            std::cout << "Entrada inválida. Por favor, ingrese un número diferente de 0.\n";
            std::cin.clear(); 
            std::cin.ignore(10000, '\n');
        }
        else{
            break;
        }
    }

    while(true){
        std::cout << "Ingrese el coeficiente b: ";
        std::cin >> b;

        if (std::cin.fail()){
            std::cout << "Entrada inválida. Por favor, ingrese un número.\n";
            std::cin.clear();
            std::cin.ignore(10000, '\n');
        }
        else{
            break;
        }
    }
   
    while(true){
        std::cout << "Ingrese el coeficiente c: ";
        std::cin >> c;

        if(std::cin.fail()){
            std::cout << "Entrada inválida. Por favor, ingrese un número.\n";
            std::cin.clear();
            std::cin.ignore(10000, '\n');
        }
        else{
            break;
        }
    }

    return new Cuadratica(a, b, c);
}

Polinomio* crearPolinomio(){
    int n;

    while(true){
        std::cout << "Ingrese el número de términos del polinomio que desea estudiar: ";
        std::cin >> n;

        if(std::cin.fail() || n <= 0){
            std::cout << "Entrada inválida. Por favor, ingrese un número entero positivo.\n";
            std::cin.clear();
            std::cin.ignore(10000, '\n');
        }
        else{
            break;
        }
    }

    std::vector<Termino> terminos(n);

    for(int i = 0; i < n; ++i){
        while(true){
            std::cout << "Ingrese el coeficiente del término " << i + 1 << ": ";
            std::cin >> terminos[i].coeficiente;

            if(std::cin.fail()){
                std::cout << "Entrada inválida. Por favor, ingrese un número.\n";
                std::cin.clear();
                std::cin.ignore(10000, '\n');
            }
            else{
                break;
            }
        }

        while(true){
            std::cout << "Ingrese el exponente del término " << i + 1 << ": ";
            std::cin >> terminos[i].exponente;

            if(std::cin.fail()){
                std::cout << "Entrada inválida. Por favor, ingrese un número entero.\n";
                std::cin.clear();
                std::cin.ignore(10000, '\n');
            }
            else{
                break;
            }
        }
    }

    return new Polinomio(terminos);
}

void menuPolinomio(Polinomio* polinomio){
    int opcion;
    do{
        std::cout << "\nMenu de Polinomio:\n" << std::endl;
        polinomio->mostrarPolinomio();
        std::cout << "1. Calcular límite\n";
        std::cout << "2. Calcular derivada\n";
        std::cout << "3. Calcular integral\n";
        std::cout << "4. Mostrar propiedades\n";
        std::cout << "5. Salir\n";
        std::cout << "Ingrese su opción: ";
        std::cin >> opcion;

        float x, a, b;
        char calcularDefinida;

        switch(opcion){
            case 1:
                std::cout << "Ingrese el valor al cual tiende la función para calcular el límite: ";
                std::cin >> x;
                std::cout << "El límite de la función cuando x tiende a = " << x << " es: " << polinomio->limite(x) << std::endl;
                break;
            case 2:{
                Polinomio derivada = polinomio->derivada();
                std::cout << "\nLa derivada de la función polinomica es: "; 
                derivada.mostrarPolinomio(); 
                break;
            }
            case 3:{
                Polinomio integral = polinomio->integral();
                std::cout << "\nLa integral de la función polinomica es: ";
                integral.mostrarPolinomio();
                
                std::cout << "¿Desea calcular la integral definida? (s/n): ";
                std::cin >> calcularDefinida;

                if(calcularDefinida == 's' || calcularDefinida == 'S'){
                    std::cout << "Ingrese el límite inferior de integración: ";
                    std::cin >> a;
                    std::cout << "Ingrese el límite superior de integración: ";
                    std::cin >> b;
                    std::cout << "El valor de la integral definida es: " << polinomio->integral_def(a, b) << std::endl;
                }
            }
            case 4:
                polinomio->mostrarPropiedades();
                break;
            case 5:
                std::cout << "Regresando al menú principal...\n";
                break;
            default:
                std::cout << "Opción no válida. Intente de nuevo.\n";
        }
        
    } while(opcion != 5);
}

void menuCuadratica(Cuadratica* cuadratica){
    int opcion;
    do{
        std::cout << "\nMenu de Cuadrática:\n" << std::endl;
        cuadratica->mostrarPolinomio();
        std::cout << "1. Calcular límite\n";
        std::cout << "2. Calcular derivada\n";
        std::cout << "3. Calcular integral\n";
        std::cout << "4. Mostrar propiedades\n";
        std::cout << "5. Mostrar gráfico\n";
        std::cout << "6. Salir\n";
        std::cout << "Ingrese su opción: ";
        std::cin >> opcion;

        float x, a, b;
        char calcularDefinida;

        switch(opcion){
            case 1:
                std::cout << "Ingrese el valor al cual tiende la función para calcular el límite: ";
                std::cin >> x;
                std::cout << "El límite de la función cuando x tiende a = " << x << " es: " << cuadratica->limite(x) << std::endl;
                break;
            case 2:{
                Polinomio derivada = cuadratica->derivada();
                std::cout << "\nLa derivada de la función cuadrática es: "; 
                derivada.mostrarPolinomio();

                break;
            }
            case 3:{
                Polinomio integral = cuadratica->integral();
                std::cout << "\nLa integral de la función cuadrática es: ";
                integral.mostrarPolinomio();
                
                std::cout << "¿Desea calcular la integral definida? (s/n): ";
                std::cin >> calcularDefinida;

                if(calcularDefinida == 's' || calcularDefinida == 'S'){
                    std::cout << "Ingrese el límite inferior de integración: ";
                    std::cin >> a;
                    std::cout << "Ingrese el límite superior de integración: ";
                    std::cin >> b;
                    std::cout << "El valor de la integral definida es: " << cuadratica->integral_def(a, b) << std::endl;
                }
    
                break;
            }
            case 4:
                cuadratica->mostrarPropiedades();
                break;
            case 5:
                break;
            case 6:
                std::cout << "Regresando al menú principal...\n";
                break;
            default:
                std::cout << "Opción no válida. Intente de nuevo.\n";
        }
    } while(opcion != 5);
}

void menu(){

    int opcion;

    do{
        std::cout << "\nMenu:\n";
        std::cout << "1. Estudiar polinomio cuadrático\n";
        std::cout << "2. Estudiar polinomio general\n";
        std::cout << "3. Salir\n";
        std::cout << "Ingrese su opción: ";
        std::cin >> opcion;

        switch(opcion){

            case 1:{
                Cuadratica* cuadratica = crearPolinomioCuadratico();
                menuCuadratica(cuadratica);
                delete cuadratica; // Liberar la memoria
                break;
            }

            case 2:{
                Polinomio* polinomio = crearPolinomio();
                menuPolinomio(polinomio);
                delete polinomio; // Liberar la memoria
                break;
            }

            case 3:
                std::cout << "Saliendo...\n";
                break;

            default:
                std::cout << "Opción no válida. Intente de nuevo.\n";
        }

    } while(opcion != 3);
}