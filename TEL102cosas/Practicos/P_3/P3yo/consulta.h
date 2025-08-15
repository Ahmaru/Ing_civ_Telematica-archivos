#ifndef CONSULTA_H
#define CONSULTA_H

#include <string>
#include <iostream>

class Consulta {
protected:
    std::string nombrePaciente;
    std::string especialidadMedica;
    std::string fechaConsulta;
    bool reservaConfirmada;

public:
    // Constructor
    Consulta(std::string nombrePaciente,std::string especialidadMedica,)

    // Método para confirmar reserva
    void confirmarReserva() {
        reservaConfirmada = true;
        std::cout << "La reserva ha sido confirmada." << std::endl;
    }

    // Método virtual puro
    virtual void mostrarDetalles() const = 0;

    // Destructor virtual
    virtual ~Consulta() = default;
};

#endif CONSULTA_H