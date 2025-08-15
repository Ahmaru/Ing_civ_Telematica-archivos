#include <iostream>
#include <stdlib.h>
	
struct nivel {
	int n_filas = 3; // Número de filas de espacios
	int n_columnas = 3; // Número de columnas de espacios
	char nombre_nivel[50]; // Nombre del nivel
	bool espacio[3][3]; // Estado por espacio según fila-columna: Libre (false) u Ocupado (true)
};

nivel initNivel(nivel n); void showNivelState(nivel n);nivel modifyReservation(nivel n, int fila,int columna,bool estado);


int main(){
	nivel estacionamiento; char verificador;

	std::cout<<"Ingrese el nombre del nivel: "; std::cin.getline(estacionamiento.nombre_nivel,100);

	estacionamiento = initNivel(estacionamiento);

	do{
		std::cout<<"Seleccione una opción:\n1. Reservar/liberar espacio en el nivel ("<<estacionamiento.nombre_nivel<<")\nx.Salir \nOpcion: ";
		std::cin>>verificador; std::cin.ignore();

		if(verificador == '1'){
			int fila; int columna; char usar;bool lindo;

			showNivelState(estacionamiento);

			std::cout<<"Ingrese la fila (0-2): "; std::cin >> fila;
			std::cout<<"Ingrese la columna (0-2): "; std:: cin >> columna;

			std::cout<<"Reservar (r) o liberar (1) el espacio: "; std::cin>>usar;

			lindo = (usar == 'r') ? true : false;

			estacionamiento = modifyReservation(estacionamiento,fila,columna,lindo);

			showNivelState(estacionamiento);

		}else if(verificador == 'x'){
			std::cout<<"Gracias por usar el sistema de reservas. !Disfrute su día¡ \n";
			break;

		}else{
			std::cout<<"Opción inválida, intente nuevamente.";
		}
	}while(true);

	return 0;
}

nivel initNivel(nivel n){
	//nivel nivelinit; si la necesito despues.
	int i; int j;

	for(i = 0; i < n.n_filas; i++){
		for(j = 0; j < n.n_columnas; j++){
			n.espacio[i][j] = false;
		}
	}

	return n;
}

void showNivelState(nivel n){
	//char verificar;

	std::cout<< "Nivel: " << n.nombre_nivel<<std::endl;
	
	std::cout<<"Estado de los espacios: \n";

	for(int i = 0; i < 3 ;i++){
		for(int j = 0; j < 3; j++){
			if(n.espacio[i][j] == true){
				std::cout<< " x ";
			}else{
				std::cout<<" o ";
			}
		}
		std::cout<< "\n";
	}
}

nivel modifyReservation(nivel n, int fila,int columna,bool estado){
	//char reservacion;

	//std::cout<<"Reservar (r) o liberar (1) el espacio: ";
	//std::cin >> reservacion; std::cin.ignore();

	n.espacio[fila][columna] = estado;
	std::cout<<"Reserva modificada\n";

	return n;
}	
