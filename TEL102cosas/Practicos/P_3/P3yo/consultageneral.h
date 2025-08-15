#ifndef CONSULTAGENERAL_H
#define CONSULTAGENERAL_H

#include "consulta.h"

class ConsultaGeneral : public Consulta {
private:
    std::string nombreMedico;

public:
    // Constructor
    ConsultaGeneral(const std::string& nombre, const std::string& especialidad, const std::string& fecha, const std::string& medico)
        : Consulta(nombre, especialidad, fecha), nombreMedico(medico) {}

    // Implementación de mostrarDetalles
    void mostrarDetalles() const override {
        std::cout << "Consulta General - Paciente: " << nombrePaciente << std::endl;
        std::cout << "Especialidad: " << especialidadMedica << ", Fecha: " << fechaConsulta << std::endl;
        std::cout << "Médico: " << nombreMedico << std::endl;
        std::cout << "Reserva confirmada: " << (reservaConfirmada ? "Sí" : "No") << std::endl;
    }
};

#endif CONSULTAGENERAL_H