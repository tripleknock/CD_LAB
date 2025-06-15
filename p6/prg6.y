%{
#include <stdio.h>
#include <stdlib.h>

// Structure to store intermediate code
struct incod {
    char opd1, opd2, opr;
} code[20];

int ind = 0;
char temp = 'T'; // For temporary variables T, U, V...
int syntax_error = 0;

// Function prototypes
int yylex(void);
int yyerror(const char *s);
char AddToTable(char, char, char);
void generateCode();
%}

%union { char sym; }

%token <sym> LETTER NUMBER
%type <sym> expr
%left '+' '-'
%left '*' '/'
%right '='

%%

statement:
      LETTER '=' expr ';'      { AddToTable($1, $3, '='); }
    | expr ';'
    ;

expr:
      expr '+' expr            { $$ = AddToTable($1, $3, '+'); }
    | expr '-' expr            { $$ = AddToTable($1, $3, '-'); }
    | expr '*' expr            { $$ = AddToTable($1, $3, '*'); }
    | expr '/' expr            { $$ = AddToTable($1, $3, '/'); }
    | '(' expr ')'             { $$ = $2; }
    | NUMBER                   { $$ = $1; }
    | LETTER                   { $$ = $1; }
    ;

%%

char AddToTable(char opd1, char opd2, char opr) {
    code[ind].opd1 = opd1;
    code[ind].opd2 = opd2;
    code[ind].opr  = opr;
    return (ind++) + temp;
}

void generateCode() {
    printf("\nThree-Address Code:\n");
    for (int i = 0; i < ind; i++) {
        if (code[i].opr == '=') {
            printf("%c = %c\n", code[i].opd1, code[i].opd2);
        } else {
            printf("%c = %c %c %c\n", temp + i, code[i].opd1, code[i].opr, code[i].opd2);
        }
    }

    printf("\nQuadruple Representation:\n");
    for (int i = 0; i < ind; i++) {
        if (code[i].opr == '=') {
            printf("%d\t=\t%c\t_\t%c\n", i, code[i].opd2, code[i].opd1);
        } else {
            printf("%d\t%c\t%c\t%c\t%c\n", i, code[i].opr, code[i].opd1, code[i].opd2, temp + i);
        }
    }

    printf("\nTriple Representation:\n");
    for (int i = 0; i < ind; i++) {
        printf("%d\t%c\t%c\t%c\n", i, code[i].opr, code[i].opd1, code[i].opd2);
    }
}

int yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
    syntax_error = 1;
    return 0;
}

int main() {
    printf("Enter the Expression (end with `;`):\n");
    yyparse();
    if (!syntax_error)
        generateCode();
    return 0;
}

//yacc -d prg6.y
//lex prg6.l
//gcc lex.yy.c y.tab.c -o prg6 -ll
//./prg6
