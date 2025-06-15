%{
#include <stdio.h>
#include <stdlib.h>

int count = 0;
int yylex();
void yyerror(const char *s);
%}

%token IF ALPHA NUM GE LE EQ LPAREN RPAREN LF RF NEQ

%%

S : I ;

I : IF A B        { count++; }
  ;

A : LPAREN E RPAREN ;

E : ALPHA Z ALPHA
  | ALPHA Z NUM
  ;

Z : '<' 
  | '>' 
  | GE 
  | LE
  | NEQ
  ;

B : ALPHA
  | ALPHA I
  | LF B RF
  | I
  ;

%%

int main() {
    printf("Enter an expression:\n");
    yyparse();
    printf("Number of if loops are %d\n", count);
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid: %s\n", s);
    exit(1);
}

// lex prg4b.l
// yacc -d prg4b.y
// gcc lex.yy.c y.tab.c -o prg4b -ll
// ./prg4b
