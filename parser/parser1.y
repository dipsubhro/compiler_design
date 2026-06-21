%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

%token INT FLOAT CHAR VOID RETURN ID NUM
%token STRING

%%

program:
    declarations
    ;
    
declarations:
    declarations declaration
    | declaration
    ;

declaration:
    type_specifier ID '(' ')' compound_stmt
    | type_specifier ID ';'
    ;

type_specifier:
    INT
    | FLOAT
    | CHAR
    | VOID
    ;

compound_stmt:
    '{' statements '}'
    ;

statements:
    statements statement
    | /* empty */
    ;

statement:
    var_declaration
    | expression_statement
    | function_call
    ;

var_declaration:
    type_specifier ID '=' expression ';'
    | type_specifier ID ';'
    ;

expression_statement:
    expression ';'
    ;

expression:
    expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | ID
    | NUM
    | STRING
    ;

function_call:
    ID '(' arguments ')' ';'
    ;

arguments:
    arguments ',' expression
    | expression
    | STRING
    | /* empty */
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error at line %d: %s\n", yylineno, s);
}

int main(int argc, char *argv[]) {
    if (yyparse() == 0) {
        printf("Parsing Sucessfully. Valid C program.\n");
    }
    return 0;
}

