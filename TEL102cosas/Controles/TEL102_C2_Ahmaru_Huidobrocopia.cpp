#include <iostream>

// Estructura para almacenar la información de un dispositivo robótico
struct dispositivo {
	char nombre[100];  // Nombre del dispositivo (ej. Sensor Óptico)
	char tipo[50];     // Tipo de dispositivo (ej. Sensor, Actuador)
};

// Estructura para almacenar la información de las líneas de ensamblaje
struct linea_ensamblaje {
	char nombre[100];  // Nombre de la línea de ensamblaje (ej. Línea Alfa)
	int n_dispositivos; // Número de dispositivos asignados
	dispositivo* dispositivos; // Arreglo dinámico de dispositivos
};

// Prototipos de las funciones
linea_ensamblaje* registrarLinea();
void asignarDispositivos(linea_ensamblaje& le);
void mostrarLinea(linea_ensamblaje& le);

int main() {
	linea_ensamblaje* lineaActual = registrarLinea();
	// Ojo, se derreferencia antes de entregar la línea de ensamblaje!


	asignarDispositivos(*lineaActual); 

	mostrarLinea(*lineaActual);

	delete[] lineaActual->dispositivos;

	delete lineaActual;	


	return 0;
}

// Escriba aquí el código de las funciones solicitadas

linea_ensamblaje* registrarLinea(){
	linea_ensamblaje* nuevo = new linea_ensamblaje;
	
	std::cout<<"Registrando nueva linea de ensamblaje."<<std::endl;

	std::cout<<"Ingrese nombre de la linea: ";
	std::cin.getline(nuevo->nombre,100);

	std::cout<<"Ingrese cantidad de dispositivos: ";
	std::cin>>nuevo->n_dispositivos;
	std::cin.ignore();
	std::cout<<"\n";

	nuevo->dispositivos = new dispositivo[(nuevo->n_dispositivos)];

	return nuevo;
}

void asignarDispositivos(linea_ensamblaje& le){
	std::cout<<"Asignando dispositivos para la línea: "<<le.nombre<<"\n"<<std::endl;

	for(int i = 0; i < le.n_dispositivos; i++){
		std::cout<<"Ingrese nombre del dispositivo: ";
		std::cin.getline(le.dispositivos[i].nombre,100);

		std::cout<<"Ingrese el tipo del dispositivo: ";
		std::cin.getline(le.dispositivos[i].tipo,50);

		std::cout<<"¡Dispositivo asignado! \n"<<std::endl;
	}
}

void mostrarLinea(linea_ensamblaje& le){
	std::cout<<"Mostrando información para la línea de ensamblaje: "<< le.nombre<<"\n"<<std::endl;

	std::cout<<"Numero de dispositivos: "<<le.n_dispositivos<<std::endl;

	for(int i = 0; i < le.n_dispositivos ; i++){
		std::cout<<"Dispositivo "<<le.dispositivos[i].nombre<<". Tipo: "<<le.dispositivos[i].tipo<<std::endl;
	}
}

