%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
%}
%start S
%%
S: A B ;

A: 'a' A 'b'
 | /* empty */ ;

B: 'b' B 'c'
 | /* empty */ ;
%%
int main() {
    printf("Enter string:\n");
    if (yyparse() == 0)
        printf("Valid\n");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Invalid\n");
    exit(1);
}

//lex prg1b.l
//yacc -d prg1b.y
//gcc lex.yy.c y.tab.c -o prg1b -ll
//./prg1b
