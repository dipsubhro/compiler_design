#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_STATES 10
#define MAX_SYMBOL 4
#define MAX_STATE_LENGTH 3


typedef struct {
    char from[MAX_STATE_LENGTH];
    char symbol;
    char to[MAX_STATE_LENGTH];
} Transition;


void epsilonClosure(char state[], Transition transitions[], int numTransitions, char closure[][MAX_STATE_LENGTH], int *closureSize) {
    char stack[MAX_STATES][MAX_STATE_LENGTH];
    int top = -1;
    int visited[MAX_STATES] = {0};
    
   
    strcpy(closure[*closureSize], state);
    (*closureSize)++;
    strcpy(stack[++top], state);
    
    while (top >= 0) {
        char currentState[MAX_STATE_LENGTH];
        strcpy(currentState, stack[top--]);
        
      
        for (int i = 0; i < numTransitions; i++) {
            if (strcmp(transitions[i].from, currentState) == 0 && transitions[i].symbol == 'e') { // epsilon transition
                char nextState[MAX_STATE_LENGTH];
                strcpy(nextState, transitions[i].to);
                
                int alreadyInClosure = 0;
                for (int j = 0; j < *closureSize; j++) {
                    if (strcmp(closure[j], nextState) == 0) {
                        alreadyInClosure = 1;
                        break;
                    }
                }
                
                if (!alreadyInClosure) {
                    strcpy(closure[*closureSize], nextState);
                    (*closureSize)++;
                    strcpy(stack[++top], nextState);
                }
            }
        }
    }
}

int main() {
    int numTransitions;
    char state[MAX_STATE_LENGTH];
    Transition transitions[MAX_STATES];
    
  
    printf("Enter the number of transitions: ");
    scanf("%d", &numTransitions);
    
  
    printf("Enter transitions (from symbol to):\n");
    for (int i = 0; i < numTransitions; i++) {
        scanf(" %s %c %s", transitions[i].from, &transitions[i].symbol, transitions[i].to);
    }
    
  
    printf("Enter the state: ");
    scanf(" %s", state);
    
    char closure[MAX_STATES][MAX_STATE_LENGTH];
    int closureSize = 0;
    
  
    epsilonClosure(state, transitions, numTransitions, closure, &closureSize);
    
  
    printf("Epsilon Closure of state %s: ", state);
    for(int i = 0; i < closureSize; i++){
        printf("%s ", closure[i]);
    }
    printf("\n");
    
    return 0;
}

