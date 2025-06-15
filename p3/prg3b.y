%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
int count=0, error=0;
%}

%token FOR LPAREN RPAREN LF RF ALPHA NUM UPDATE
%token ADDEQ SUBEQ EQ LE GE INC DEC

%%

S : Block {
    if (count >= 3 && !error) {
        printf("Valid\nNumber of FOR loops = %d\n", count);
    } else {
        printf("Error\n");
    }
};

Block : FOR LoopHeader LoopBody {
        count++;
    }
    | FOR LoopHeader LoopBody Block
    ;

LoopHeader : LPAREN Exp ';' Exp ';' Exp RPAREN ;

Exp : ALPHA Op ALPHA 
    | ALPHA Op NUM
    | ALPHA Update
    |
    ;

LoopBody : LF Block RF
         | LF RF
         ;

Op : '=' | '<' | '>' | EQ | ADDEQ | SUBEQ | LE | GE ;

Update : INC | DEC ;

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the loop:\n");
    yyparse();
    return 0;
}
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    error = 1;
}

//lex prg3b.l
// yacc -d prg3b.y
// gcc lex.yy.c y.tab.c -o prg3b -ll
// ./prg3b
