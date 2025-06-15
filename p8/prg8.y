%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char* s);
int yylex(void);

%}

%union {
    char* id;
    int num;
    char* str;
}

%token <id> ID
%token <num> NUM
%token <str> STRING
%token INT MAIN PRINTF ADD ASSIGN LPAREN RPAREN SEMI COMMA LBRACE RBRACE

%start program

%%

program:
    INT MAIN LPAREN RPAREN LBRACE stmt_list RBRACE
    {
        printf("    ret\n");
    }
;

stmt_list:
    stmt
    | stmt_list stmt
;

stmt:
    INT ID ASSIGN NUM SEMI
    {
        printf("    movl $%d, %%%s\n", $4, $2);
    }
    |
    ID ASSIGN ID ADD ID SEMI
    {
        printf("    movl %%%s, %%eax\n", $3);
        printf("    addl %%%s, %%eax\n", $5);
        printf("    movl %%eax, %%%s\n", $1);
    }
    |
    PRINTF LPAREN STRING COMMA ID RPAREN SEMI
    {
        printf("    movl %%%s, %%esi\n", $5);
        printf("    movl $.LC0, %%edi\n");
        printf("    xor %%eax, %%eax\n");
        printf("    call printf\n");
    }
;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
    exit(1);
}

int main() {
    printf(".data\n");
    printf(".LC0: .string \"Sum %%d\\n\"\n");
    printf(".text\n");
    printf(".globl main\n");
    printf("main:\n");
    printf("Enter your code and press Ctrl+D when done:\n");
    yyparse();
    return 0;
}

// lex prg8.l
// yacc -d prg8.y
// gcc lex.yy.c y.tab.c -o prg8 -ll
// ./prg8
