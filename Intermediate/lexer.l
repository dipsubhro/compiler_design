%{
#include "parser.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+          { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*    { yylval.str = strdup(yytext); return ID; }

"="             return ASSIGN;
";"             return SEMICOLON;
"("             return LPAREN;
")"             return RPAREN;
"+"             return PLUS;
"-"             return MINUS;
"*"             return MUL;
"/"             return DIV;

[ \t\n\r]+      /* skip whitespace */

.               { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

