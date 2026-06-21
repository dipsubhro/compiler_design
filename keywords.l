%{
#include <stdio.h>
#include <string.h>
%}

%%
[ \t\n]+           ;  /* Ignore one or more spaces, tabs, and newlines */
int|float|if|else|return { printf("Keyword: %s\n", yytext); }
[A-Za-z_][A-Za-z0-9_]* { printf("Identifier: %s\n", yytext); }
.|\n                ; /* Match any single character not matched before (including newline) */
%%

int yywrap() {
    return 1; /* Indicate end of input */
}

int main() {
    printf("Enter some code (press Ctrl+D or Ctrl+Z then Enter to end):\n");
    yylex();
    return 0;
}