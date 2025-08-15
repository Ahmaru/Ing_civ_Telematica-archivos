#include <iostream>
#include <cmath>


// Calcula la coordenada x del vertice de la parábola, con la formula -b / (2 * a)
float CalcularVerticeX(float a, float b, float c){
    return -b/(2*a);
}


// Calcula la coordenada Y del vertice usando el vertice x en la ecuación cuadrática
float CalcularVerticeY(float a, float b, float c){
    float Vx = CalcularVerticeX(a,b,c);
    float Vy = ((a*Vx*Vx) + (b*Vx) + (c));

    return Vy;
}


// Calcula el discriminante: b^2 - 4ac
float CalcularDiscriminante(float a, float b, float c){
    float discriminante = b * b - 4 * a * c;
    return discriminante;
}


// Evalúa la función cuadrática en un punto x
float f(float a, float b, float c, float x){
    return a * x * x + x * b + c;
}


// Calcula y muestra las raices de la ecuación según el discriminante
void Raices(float a, float b, float c){

    float discriminante = CalcularDiscriminante(a, b, c);

    if (discriminante < 0){
        std::cout << "La ecuación cuadrática tiene un discriminante negativo, por lo tanto, tiene raices complejas" << std::endl;
    }
    

    else if (discriminante == 0){
        
        float raiz = (-1 * b)/(2 * a);

        std::cout << "La ecuación cuadrática un discriminante igual a 0, por lo tanto, tiene una raíz real (raíz doble)" << std::endl;
        std::cout << "Raiz de la ecuación: " << raiz << std::endl;
    }
    

    else if (discriminante > 0){
        
        float raiz1 = ((-1 * b) + sqrt(discriminante))/(2 * a);

        float raiz2 = ((-1 * b) - sqrt(discriminante))/(2 * a);

        std::cout << "La ecuación cuadrática tiene un discriminante positivo, por lo tanto, posee 2 soluciones reales y distintas, las cuales son:" << std::endl;
        std::cout << "Raíz 1: " << raiz1 << std::endl;
        std::cout << "Raíz 2: " << raiz2 << std::endl;
    }
}


// Muestra las coordenadas del vertice de la parábola
void Vertice(float a, float b, float c){
    float Vx = CalcularVerticeX(a,b,c);

    float Vy = CalcularVerticeY(a,b,c);

    std::cout<<"La coordenada del vertice es: \nX: " << Vx <<"\nY: "<<Vy<<std::endl;
}


// Muestra el eje de simetría de la parábola (x = Vx)
void EjeSimetria(float a, float b, float c){
    float Simetrico = CalcularVerticeX(a, b, c);

    std::cout<<"El eje de simetria es la recta x = "<<Simetrico<<std::endl;
}


// Indica si la parábola es convexa o cóncava según el valor de "a"
void Concavidad(float a){

    if (a>0){
        std::cout << "La función tiene un valor de \"a\" mayor que 0, por tanto la función es convexa (Curva con forma de cara feliz)" << std::endl;
    }

    else{
        std::cout << "La función tiene un valor de \"a\" menor que 0, por tanto la función es concava (Curva con forma de cara triste)" << std::endl;
    }
}


// Muestra el intercepto en el eje Y (valor de c)
void InterceptoY(float c) {
    std::cout << "El intercepto en el eje Y es: " << c << std::endl;
}



void MenuInteractivo(float a, float b, float c){
    
    int opcion = 0;
    int punto;

    do{
        
        std::cout << "\n---------------------------------\n";
        std::cout << "------ f(x) = " << a << "x² + " << b << "x + " << c << " ------";
        std::cout << "\n---------------------------------\n";
        std::cout << "1. Calcular Raíces\n";
        std::cout << "2. Calcular Vértice\n";
        std::cout << "3. Evaluar la funcion en algun punto\n";
        std::cout << "4. Mostrar Eje de Simetría\n";
        std::cout << "5. Mostrar Concavidad\n";
        std::cout << "6. Mostrar Intercepto en el Eje Y\n";
        std::cout << "7. Salir\n";
        std::cout << "Seleccione una opción: ";
        std::cin >> opcion;
        std::cout << "---------------------------------\n";
        std::cout << std::endl;
        
        switch (opcion){
            case 1:
                Raices(a, b, c);
                break;
            case 2:
                Vertice(a, b, c);
                break;
            case 3:
                std::cout << "Ingrese el punto que deseas evaluar: ";
                std::cin >> punto;
                std::cout << "\nLa función en el punto " << punto << " (f(" << punto << ")) = " << f(a, b, c, punto) << std::endl; 
                break;
            case 4:
                EjeSimetria(a, b, c);
                break;
            case 5:
                Concavidad(a);
                break;
            case 6:
                InterceptoY(c);
                break;
            case 7:
                std::cout << "Saliendo...\n";
                break;
            default:
                std::cout << "Opcion invalida\n";
                break;
        }

    } while (opcion != 7);
}
