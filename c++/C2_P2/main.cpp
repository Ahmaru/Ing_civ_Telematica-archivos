#include "Usuario.h"
#include "UsuarioNormal.h"
#include "UsuarioPremium.h"
#include "Banco.h"

int main(){

    Banco *patito = new Banco();
    UsuarioNormal* user1 = new UsuarioNormal("Ana",1000);
    UsuarioPremium* user2 = new UsuarioPremium("Beto",1000);

    patito->agregarUsuario(user1);
    patito->agregarUsuario(user2);

    patito->transferir(user1->getNombre(),user2->getNombre(),100);
    patito->transferir(user2->getNombre(),user1->getNombre(),5000);
    patito->transferir(user2->getNombre(),user1->getNombre(),200);

    patito->mostrarSaldos();
    patito->mostrarHistorial();

    return 0;
}