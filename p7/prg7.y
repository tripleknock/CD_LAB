%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token TYP ID LP RP LB RB SC CM EQ OP RETURN NUM

%left OP
%left EQ

%%

prog:
    funcs
    ;

funcs:
      func
    | funcs func
    ;

func:
    TYP ID LP params RP LB stmts RB
    {
        printf("Function is syntactically correct.\n");
    }
    ;

params:
      /* empty */
    | param_list
    ;

param_list:
      param
    | param_list CM param
    ;

param:
    TYP ID
    ;

stmts:
      stmt
    | stmts stmt
    ;

stmt:
      var_decl
    | expr SC
    | RETURN expr SC
    ;

var_decl:
      TYP ID SC
    | TYP ID EQ expr SC
    ;

expr:
      ID
    | NUM
    | ID EQ expr
    | expr OP expr
    | LP expr RP
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter C function code (end with #):\n");
    return yyparse();
}

//lex prg7.l
// yacc -d prg7.y
// gcc lex.yy.c y.tab.c -o prg7 -ll
//./prg7
