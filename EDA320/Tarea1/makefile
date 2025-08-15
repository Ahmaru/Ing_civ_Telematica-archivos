#Condiciones de compilacion.
#Sabiendo que siempre se daran los archivos de lectura como argumentos del programa los defino dinamicamente.

CC = gcc
Cflags = -Wall -g -std=gnu99
LIB = ravk.h
TARGET = MortalKombat
OBJS = main.o roster.o towers.o tournament.o
#ARGS = estudiantes_elegibles.csv profesores_npc.csv

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(Cflags) -o $(TARGET) $(OBJS)

main.o : main.c $(LIB)
	$(CC) $(Cflags) -c main.c

roster.o: roster.c $(LIB)
	$(CC) $(Cflags) -c roster.c

towers.o: towers.c $(LIB)
	$(CC) $(Cflags) -c towers.c 

tournament.o: tournament.c $(LIB)
	$(CC) $(Cflags) -c tournament.c

run: all
	./$(TARGET)

valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)

clean:
	rm -f $(TARGET) $(OBJS)