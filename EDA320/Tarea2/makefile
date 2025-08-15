#Condiciones de compilacion.
#Sabiendo que siempre se daran los archivos de lectura como argumentos del programa los defino dinamicamente.

CC = gcc
Cflags = -Wall -g -std=gnu99
LIB = discordia.h
TARGET = guess
OBJS = main.o lectura.o complex.o
file=1.dis 2.dis 3.dis 4.dis 5.dis 6.dis 7.dis 8.dis

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(Cflags) -o $(TARGET) $(OBJS)

main.o : main.c $(LIB)
	$(CC) $(Cflags) -c main.c

lectura.o : lectura.c $(LIB)
	$(CC) $(Cflags) -c lectura.c

complex.o : complex.c $(LIB)
	$(CC) $(Cflags) -c complex.c

run: all
	./$(TARGET) $(file) 

valgrind: all
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET) $(file)

clean:
	rm -f $(TARGET) $(OBJS) *.ppm