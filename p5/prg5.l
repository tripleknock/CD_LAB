%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
extern YYSTYPE yylval;
%}

%%
"int" {return INT;}
"float" {return FLOAT;}
"char" {return CHAR;}
"double" {return DOUBLE;}
[a-zA-Z_][a-zA-Z0-9_]* {return IDENTIFIER;}
[0-9]+ {return NUM;}
"," {return ',';}
";" {return ';';}
"[" {return '[';}
"]" {return ']';}

[ \t\n] {}
"#" {return 0;}
. {}
%%

// lex prg5.l
// yacc -d prg5.y
// gcc lex.yy.c y.tab.c -o prg5 -ll
// ./prg5

// i/p 
/* Enter the declarations
int a[10],a,b,c;
Total number of variables = 4
*/
