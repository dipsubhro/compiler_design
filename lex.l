%{
#include <stdio.h>
#include <string.h>


char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "inline", "int", "long", "register", "restrict", "return", "short",
    "signed", "sizeof", "static", "struct", "switch", "typedef", "union",
    "unsigned", "void", "volatile", "while", "_Alignas", "_Alignof",
    "_Atomic", "_Bool", "_Complex", "_Generic", "_Imaginary", "_Noreturn",
    "_Static_assert", "_Thread_local"
};
int isKeyword(char *word) {
    for (int i = 0; i < sizeof(keywords)/sizeof(char *); i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

%option noyywrap

%%
"#".*                                      ;   
\"([^\"\\]|\\.)*\"                         ;   
\'([^\'\\]|\\.)*\'                         ;  

[a-zA-Z_][a-zA-Z0-9_]*    {
                            if (isKeyword(yytext))
                                printf("Keyword: %s\n", yytext);
                            else
                                printf("Identifier: %s\n", yytext);
                         }

[ \t\n]+                                  ;   
.                                         ;   
%%

int main() {
    printf("Enter C code (Ctrl+D to end):\n");
    yylex();
    return 0;
}

