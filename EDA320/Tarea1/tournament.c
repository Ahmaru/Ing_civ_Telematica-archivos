#include "ravk.h"

//Stack para stats_t

void Hundredtality(int golpes){
    srand(time(NULL));

    //float probability;

    if((rand() % golpes) == 0){
        printf("\n\tBrutality\t\n");
    }
    

}

int pelea(profe_t* enemy, noob_t* player){
    float punchPlayer, punchProfe;
    int cuentagolpesPlayer = 0;
    int cuentagolpesEnemy = 0;
    int statusFight;
    float life = enemy->vida;

    punchPlayer = ((player->ataque + player->vida) * player->suerte) - enemy->defensa;
    punchProfe = ((enemy->ataque + enemy->vida) * enemy->modo_dificultad) - player->defensa;

    if(punchPlayer < 0){
        printf("Mucha defensa poco ataque.\nPerdiste insta nashei\n");
        return 0;
    }else if(punchProfe < 0){
        printf("Error en la reconstruccion.\n");
        return 0;
    }

    //Porque si.
    printf("Atacara primero el player.");

    while(1){
        enemy->vida -= punchPlayer;
        cuentagolpesPlayer++;
        printf("Golpe de %.2f del player.\n",punchPlayer);
        if(enemy->vida <= 0){
            statusFight = 1;
            break;
        }
        player->vida -= punchProfe;
        cuentagolpesEnemy++;
        printf("Golpe de %.2f del profe.\n",punchProfe);
        if(player->vida <= 0){
            statusFight = 0;
            break;
        }

    }

    if(statusFight == 1){
        Hundredtality(cuentagolpesPlayer);
        añadirSTAT(player,enemy->premio);
        enemy->vida = 0;
        enemy->vida = life;
        return statusFight;
    }else{
        printf("\tYou lose.\t\n");
        return statusFight;
    }
    return 0;

}

//Pop del stack
void freeSTACK(stats_t* stack){

    while(stack != NULL){
        stats_t* recorre = stack;
        stack = stack->sgte;
        free(recorre->premio);
        free(recorre);
    }

}

//push del stack.
void añadirSTAT(noob_t* player,char* agregar){
    stats_t* nuevo = malloc(sizeof(stats_t));
    nuevo->premio = strdup(agregar);
    nuevo->sgte = NULL;
    nuevo->contador = 0;
    if(nuevo->premio == NULL){
        printf("Error al asignar memoria.\n");
        free(nuevo);
        exit(1);
    }

    if(strcmp(agregar,"ataque") == 0){
        if(player->stats_ataque == NULL){
            player->stats_ataque = nuevo;
            player->stats_ataque->contador++;
        }else{
            if(player->stats_ataque->contador < 3){
                nuevo->sgte = player->stats_ataque;
                player->stats_ataque = nuevo;
                player->stats_ataque->contador++;
            }else if(player->stats_ataque->contador >= 3){
                freeSTACK(player->stats_ataque);
                player->ataque += 5;
                player->stats_ataque->contador = 0;
                nuevo->sgte = player->stats_ataque;
                player->stats_ataque = nuevo;
                player->stats_ataque->contador++;
                printf("Se han añadido 5 unidades al ataque.\n");
            }
        }
    }else if(strcmp(agregar,"defensa") == 0){
        if(player->stats_defensa == NULL){
            player->stats_defensa = nuevo;
            player->stats_defensa->contador++;
        }else{
            if(player->stats_defensa->contador < 3){
                nuevo->sgte = player->stats_defensa;
                player->stats_defensa = nuevo;
                player->stats_defensa->contador++;
            }else if(player->stats_defensa->contador >= 3){
                freeSTACK(player->stats_defensa);
                player->defensa += 5;
                player->stats_defensa->contador = 0;
                nuevo->sgte = player->stats_defensa;
                player->stats_defensa = nuevo;
                player->stats_defensa->contador++;
                printf("Se han añadido 5 unidades a defensa.\n");
            }
        }
    }else if(strcmp(agregar,"vida") == 0){
        if(player->stats_vida == NULL){
            player->stats_vida = nuevo;
            player->stats_vida->contador++;
        }else{
            if(player->stats_vida->contador < 3){
            nuevo->sgte = player->stats_vida;
            player->stats_vida = nuevo;
            player->stats_vida->contador++;
            }else if(player->stats_vida->contador >= 3){
                freeSTACK(player->stats_vida);
                player->vida += 5;
                player->stats_vida->contador = 0;
                nuevo->sgte = player->stats_vida;
                player->stats_vida = nuevo;
                player->stats_vida->contador++;

                printf("Se han añadido 5 unidades a vida.\n");
            }
        }
    }
    //free(agregar);
    printf("Se ha añadido el premio %s.\n",nuevo->premio);
}

int TOURNAMENT(tower_t* torre, noob_t* player){
    profe_t* guardable = NULL;
    int z;
    float life = player->vida;

    usleep(700000);
    showAvance(torre,player);
    while(torre->head != NULL){
        //showAvance(torre,player);
        usleep(1000000);
        z = pelea(torre->head,player);

        //Gano la pelea.
        if(z == 1){
            int ver;
            profe_t* recorre = torre->head;
            torre->head = torre->head->sgte;
            player->vida = life;
            moveProfeslosers(recorre,&guardable);
            if(torre->head == NULL){
                cleanLDE(&guardable);
                free(guardable);
                return ULTIMATEchampion();
            }
            printf("Continuar peleando (1), mostrar estadisticas del jugador (2), mostrar contrincantes restantes (3)\n");
            scanf("%d%*c",&ver);
            switch (ver)
            {
            case 1:
                //continue;
                printf("Proxima pelea\n\t¿PREPARADO?\n");
                break;
            case 2:
                usleep(500000);
                showNewAtributtes(player);
                usleep(3000000);
                printf("Se reanuda el torneo...\n");
                usleep(300000);
                break;
            case 3:
                usleep(500000);
                showTORRE(torre);
                usleep(3000000);
                printf("Se reanudara el torneo...\n");
                usleep(300000);
            default:
                printf("opcion invalida\n");
                break;
            }

            printf("Proximo contrincante: \n");
            showprofe(torre->head);
            usleep(4000000);

        }else{
            usleep(700000);
            printf("Deseas continuar Si(1) No(2)\n");
            int x;
            scanf("%d",&x);
            scanf("%*c");
            if(x == 1){
                remakeTower(torre,&guardable);
                player->vida = life;
                continue;
            }else{
                cleanLDE(&guardable);
                free(guardable);
                return GAMEOVER();
            }
        }
    }
    cleanLDE(&guardable);
    free(guardable);
    return ULTIMATEchampion();
}

void moveProfeslosers(profe_t* actual, profe_t** guardar){
    if((*guardar) == NULL){
        (*guardar) = actual;
        actual->prev = NULL;
        actual->sgte = NULL;
    }else{
        profe_t* recorre = (*guardar);
        while(recorre->sgte != NULL){
            recorre = recorre->sgte;
        }
        recorre->sgte = actual;
        actual->prev = recorre;
        actual->sgte = NULL;
        //recorre = actual;
    }
}

void remakeTower(tower_t* torre, profe_t** guardable){
    while((*guardable) != NULL){
        profe_t* rec = (*guardable);
        (*guardable) = (*guardable)->sgte;
        torre->head->prev = rec;
        rec->sgte = torre->head;
        rec->prev = NULL;
        torre->head = rec;
    }
}

void showTorreDif(tower_t* torre,int contador){
    printf("Torre (%d) con dificultad %s\n",(contador + 1) , (contador == 0 ? "facil" : contador == 1 ? "medio" : contador == 2 ? "dificil" : "null"));
}

void showAvance(tower_t* torre,noob_t* player){
    printf("Contrincantes: \n");
    usleep(500000);
    showTORRE(torre);
    showNewAtributtes(player);
}

int GAMEOVER() {
    printf("\n\t=========================================\n");
    printf("\t||                                     ||\n");
    printf("\t||           💀 GAME OVER 💀           ||\n");
    printf("\t||                                     ||\n");
    printf("\t=========================================\n\n");

    printf("\tHas luchado con valentía...\n");
    printf("\tPero este no fue tu torneo.\n\n");

    printf("\tLas leyendas no siempre nacen al primer intento.\n");
    printf("\t¡Entrena, regresa y reclama tu lugar en la cima!\n");

    return 1;
}

int ULTIMATEchampion() {
    printf("\n\t=========================================\n");
    printf("\t||                                     ||\n");
    printf("\t||   ¡FELICIDADES, CAMPEÓN SUPREMO!    ||\n");
    printf("\t||                                     ||\n");
    printf("\t=========================================\n\n");

    printf("\t🏆 Has superado cada desafío...\n");
    printf("\t⚔️  Has derrotado a todos tus rivales...\n");
    printf("\t👑 ¡Ahora eres el CAMPEÓN DE CAMPEONES!\n\n");

    printf("\tGracias por demostrar tu grandeza.\n");
    printf("\t¡El torneo siempre recordará tu victoria!\n");

    return 0;
}

void asignacionDatosProfe(tower_t** torres,profe_t** f,profe_t** m, profe_t** di){
    printf("Datos del nuevo personaje: \n");
    char n[50] ,p[50];
    float a,d,v,dif;

    printf("Nombre: ");
    scanf("%s%*c",n);
    printf("\n");
    n[strcspn(n,"\n")] = '\0';

    printf("Ataque: ");
    scanf("%f%*c",&a);
    printf("\n");

    printf("Defensa: ");
    scanf("%f%*c",&d);
    printf("\n");

    printf("Vida: ");
    scanf("%f%*c",&v);
    printf("\n");

    printf("Dificultad: \nfacil(1) medio(2) dificil(3)\n");
    scanf("%f%*c",&dif);
    printf("\n");

    printf("Premio (ataque) (defensa) (vida): ");
    scanf("%s%*c",p);
    printf("\n");
    p[strcspn(p,"\n")] = '\0';

    if((int) dif == 1){
        iniciarLISTA(f,n,a,d,v,dif,p);
        //CountLDE(*f);
    }else if((int) dif == 2){
        iniciarLISTA(m,n,a,d,v,dif,p);
        //CountLDE(*m);
    }else if((int) dif == 3){
        iniciarLISTA(di,n,a,d,v,dif,p);
        //CountLDE(*di);
    }

}

void asignarDatos(char_t* roster){
    printf("Datos del nuevo personaje: \n");
    char n[50];
    float a,d,v,l;

    printf("Nombre: ");
    scanf("%s",n);
    n[strcspn(n,"\n")] = '\0';

    printf("Ataque: ");
    scanf("%f%*c",&a);

    printf("Defensa: ");
    scanf("%f%*c",&d);
    
    printf("Vida: ");
    scanf("%f%*c",&v);

    printf("Suerte: ");
    scanf("%f%*c",&l);

    initLSE(roster,n,a,d,v,l);
    showEstEDA(roster);
}

void menuTorneo(tower_t** torres, char_t* roster,profe_t** facil,profe_t** medio, profe_t** dificil,int size){
    printf("\n");
    printf("\t=============================================\n");
    printf("\t||                                          ||\n");
    printf("\t||     🔥  RAV KOMBAT  🔥                  ||\n");
    printf("\t||         CHOOSE YOUR DESTINY             ||\n");
    printf("\t||                                          ||\n");
    printf("\t=============================================\n");
    printf("\n");
    int v;

    while(1){
        printf("Selecciona lo que deseas hacer\nJugar(1)\nAgregar personaje(2)\nSalir(0)\n");
        int result = scanf("%d%*c",&v);
        if(result != 1) {
            printf("Opción no válida. Intenta de nuevo.\n");
            while(getchar() != '\n'); // Limpiar buffer
            continue;
        }

        switch (v){
        case 1:{
                noob_t* player = NULL;
                tower_t* actual = NULL;
                player = Select(roster);

                actual = SelectTOWER(torres,player,size);

                v = TOURNAMENT(actual,player);
                if(v == 0){
                    printf("Gracias por jugar\nCerrando programa....\n");
                    usleep(700000);
                    return;
                }else if(v == 1){
                    printf("Has perdido el torneo.\n");
                    usleep(3000000);
                    return;
                }
            }
            break;
        case 2:{
                int b;
                printf("Estudiante(1)\nProfesor(2)\n");
                int res = scanf("%d%*c",&b);
                if(res != 1) {
                    printf("Opción no válida. Intenta de nuevo.\n");
                    while(getchar() != '\n');
                    break;
                }
                if(b == 1){
                    asignarDatos(roster);

                    printf("Se ha creado satisfactoriamente.\n");

                }else if(b == 2){
                    asignacionDatosProfe(torres,facil,medio,dificil);

                    printf("Se ha creado satisfactoriamente.\n");

                }else{
                    printf("Opción no válida. Intenta de nuevo.\n");
                }
            }
            break;
        case 0:
            printf("Gracias por jugar\nCerrando programa....");
            usleep(300000);
            return;
        default:
            printf("Opción no válida. Intenta de nuevo.\n");
            break;
        }
    }
}

void liberarMemoriaTorneo(tower_t** torres, profe_t** facil,profe_t** medio, profe_t** dificil, char_t* roster,int size){

    cleanLDE(facil);

    cleanLDE(medio);

    cleanLDE(dificil);

    cleanEst(roster);

    for(int i = 0 ; i < size ; i++){
        cleanTOWER(torres[i]);
    }

}