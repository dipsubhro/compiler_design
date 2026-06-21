%{
#include <stdio.h>
%}

%%
[0-9]+   { printf("Number: %s\n", yytext); }
[a-zA-Z]+ { printf("Identifier: %s\n", yytext); }
"+"      { printf("Operator: +\n"); }
"\n"     { printf("Newline\n"); }
[ \t]    { /* Ignore whitespace */ }
.        { printf("Unknown character: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

