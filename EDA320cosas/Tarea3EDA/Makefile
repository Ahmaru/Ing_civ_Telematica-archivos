#Pa compilar piola

CC = gcc
Cflags = -Wall -g -std=gnu99 
TARGET = programa
OBJS = main.o sorting.o 

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(Cflags) -o $(TARGET) $(OBJS) 

main.o: main.c Funciones.h
	$(CC) $(Cflags) -c main.c 

sorting.o: sorting.c Funciones.h
	$(CC) $(Cflags) -c sorting.c 


run: $(TARGET)
	./$(TARGET)

valgrind: $(TARGET)
	valgrind --leak-check=full ./$(TARGET)

clean:
	rm -f $(TARGET) $(OBJS) *.csv 
