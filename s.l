#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define TABLE_SIZE 10

typedef enum {
    TOKEN_KEYWORD,
    TOKEN_IDENTIFIER,
    TOKEN_NUMBER,
    TOKEN_OPERATOR,
    TOKEN_UNKNOWN
} TokenType;

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
            return current->address;  // Return the address if the symbol is found
        }
        current = current->next;
    }
    
    // If not found, assign a new address (random for this example)
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

TokenType getTokenType(const char* str) {
    // Check for keywords (simple check for 'if', 'else', etc.)
    if (strcmp(str, "if") == 0 || strcmp(str, "else") == 0 || strcmp(str, "while") == 0) {
        return TOKEN_KEYWORD;
    }
    
    // Check if it's a number
    for (int i = 0; str[i] != '\0'; i++) {
        if (!isdigit(str[i])) {
            return TOKEN_IDENTIFIER;
        }
    }
    return TOKEN_NUMBER;
}

void lexAnalyze(const char* input) {
    char token[50];
    int i = 0, j = 0;

    while (input[i] != '\0') {
        if (isspace(input[i])) {
            i++;
            continue;
        }

        if (isalnum(input[i]) || input[i] == '_') {  // Start of an identifier or number
            token[j++] = input[i++];
            while (isalnum(input[i]) || input[i] == '_') {  // Continue reading identifier
                token[j++] = input[i++];
            }
            token[j] = '\0';
            j = 0;

            TokenType type = getTokenType(token);
            if (type == TOKEN_IDENTIFIER) {
                int address = insertSymbol(token);
                printf("Identifier: %s, Address: %d\n", token, address);
            } else if (type == TOKEN_NUMBER) {
                printf("Number: %s\n", token);
            } else if (type == TOKEN_KEYWORD) {
                printf("Keyword: %s\n", token);
            }
        } else if (input[i] == '+' || input[i] == '-' || input[i] == '*' || input[i] == '/') {  // Operator
            printf("Operator: %c\n", input[i]);
            i++;
        } else {
            printf("Unknown character: %c\n", input[i]);
            i++;
        }
    }
}

int main() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        symbolTable[i] = NULL;
    }

    const char* code = "x = 10 + 20 if y else z";
    printf("Lexical Analysis of: \"%s\"\n", code);
    lexAnalyze(code);
    
    printSymbolTable();
    
    return 0;
}

