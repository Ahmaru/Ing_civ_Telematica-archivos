COMPILADOR = g++
ARCHIVOS = main.cpp funciones.cpp cuadratica.cpp polinomio.cpp
EJECUTABLE = main

all: compilacion

compilacion:
	$(COMPILADOR) $(ARCHIVOS) -o $(EJECUTABLE) -Wall

run:
	./$(EJECUTABLE)

clear:
	rm $(EJECUTABLE)

# Para compilar: make
# Para ejecutar el programa: make run
# Para limpiar el ejecutable: make clear