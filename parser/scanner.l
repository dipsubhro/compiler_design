%{
#include "parser1.tab.h"
extern int yylval;
extern int yylineno;
%}

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"char"          { return CHAR; }
"void"          { return VOID; }
"return"        { return RETURN; }
[a-zA-Z_][a-zA-Z0-9_]*    {return ID; }
[0-9]+          { return NUM; }
\"([^\\\"]|\\.)*\"    { return STRING; }

"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
";"             { return ';'; }
","             { return ','; }
"="             { return '='; }
"*"             { return '*'; }
"/"             { return '/'; }
"+"             { return '+'; }
"-"             { return '-'; }


"#".*    	{ /* Ignore preprocessor directives */ }
[ \t]           { /* ignore spaces and tabs */ }
\n              { yylineno++; }
.               { /* ignore other characters for now */ }


%%

int yywrap() {
    return 1;
}

