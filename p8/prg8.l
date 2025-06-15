%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z0-9_]*
WS      [ \t\n]+
STRING  \"[^"]*\"

%%

"int"           { return INT; }
"main"          { return MAIN; }
"printf"        { return PRINTF; }
{STRING}        { yylval.str = strdup(yytext); return STRING; }
{ID}            { yylval.id = strdup(yytext); return ID; }
{DIGIT}+        { yylval.num = atoi(yytext); return NUM; }
"+"             { return ADD; }
"="             { return ASSIGN; }
"("             { return LPAREN; }
")"             { return RPAREN; }
";"             { return SEMI; }
","             { return COMMA; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
{WS}            { /* skip whitespace */ }

%%

int yywrap() { return 1; }

// lex prg8.l
// yacc -d prg8.y
// gcc lex.yy.c y.tab.c -o prg8 -ll
// ./prg8

/* i/p => int main() { int a = 5; int b = 10; a = a + b; printf("Sum %d", a); } */
/* .data
.LC0: .string "Sum %d\n"
.text
.globl main
main:
Enter your code and press Ctrl+D when done:
int main() { int a = 5; int b = 10; a = a + b; printf("Sum %d", a); }    movl $5, %a
    movl $10, %b
    movl %a, %eax
    addl %b, %eax
    movl %eax, %a
    movl %a, %esi
    movl $.LC0, %edi
    xor %eax, %eax
    call printf
    ret
    
*/
