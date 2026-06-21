#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TABLE_SIZE 10


typedef struct Symbol {
    char name[50];  
    int address;    
    struct Symbol* next;  
} Symbol;


Symbol* symbolTable[TABLE_SIZE];


unsigned int hash(const char* str) {
    unsigned int hashValue = 0;
    while (*str) {
        hashValue = (hashValue << 5) + *str++;
    }
    return hashValue % TABLE_SIZE;
}


Symbol* createSymbol(const char* name, int address) {
    Symbol* newSymbol = (Symbol*)malloc(sizeof(Symbol));
    strcpy(newSymbol->name, name);
    newSymbol->address = address;
    newSymbol->next = NULL;
    return newSymbol;
}


int insertSymbol(const char* name) {
    unsigned int index = hash(name);
    
    
    Symbol* current = symbolTable[index];
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current->address;  
        }
        current = current->next;
    }
    
   
    int newAddress = rand() % 1000;  
    Symbol* newSymbol = createSymbol(name, newAddress);
    

    newSymbol->next = symbolTable[index];
    symbolTable[index] = newSymbol;
    
    return newAddress;  
}


void printSymbolTable() {
    printf("\nSymbol Table:\n");
    for (int i = 0; i < TABLE_SIZE; i++) {
        if (symbolTable[i] != NULL) {
            Symbol* current = symbolTable[i];
            while (current != NULL) {
                printf("Name: %s, Address: %d\n", current->name, current->address);
                current = current->next;
            }
        }
    }
}

int main() {
    
    for (int i = 0; i < TABLE_SIZE; i++) {
        symbolTable[i] = NULL;
    }
    
   
    printf("Address of x: %d\n", insertSymbol("x"));
    printf("Address of y: %d\n", insertSymbol("y"));
    printf("Address of z: %d\n", insertSymbol("z"));
    printf("Address of x (duplicate): %d\n", insertSymbol("x"));
    printf("Address of a: %d\n", insertSymbol("a"));
    
  
    printSymbolTable();
    
    return 0;
}



