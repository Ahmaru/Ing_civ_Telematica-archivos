#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct Hashnode{
    int key;
    int value;
    struct Hashnode* next;
}HN;

typedef struct Hashtable{
    HN** table;
    int size;
}HT;

int hashFunction(int key, int tableSize);
void insert(HT* hashTable, int key, int value);
int search(HT* hashTable, int key);
HT* createTable(int size);


int main(int argc,char** argv){

    

    return 0;
}

void insert(HT* hashTable, int key, int value) {
    int index = hashFunction(key, hashTable->size);
    HN* newNode = (HN*)malloc(sizeof(HN));
    newNode->key = key;
    newNode->value = value;
    newNode->next = hashTable->table[index];
    hashTable->table[index] = newNode;
}

int hashFunction(int key, int tableSize){
    return key % tableSize;
}

int search(HT* hashTable, int key){
    int index = hashFunction(key, hashTable->size);
    HN* current = hashTable->table[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value; // Clave encontrada
        }
        current = current->next;
    }
    return -1; // Clave no encontrada
}

HT* createTable(int size){
    HT* hashTable = (HT*)malloc(sizeof(HT));
    hashTable->size = size;
    hashTable->table = (HN**)malloc(size * sizeof(HN*));
    for (int i = 0; i < size; i++) {
        hashTable->table[i] = NULL;
    }
    return hashTable;
}
