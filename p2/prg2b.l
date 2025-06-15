%{
#include<stdio.h>
#include"y.tab.h"
extern YYSTYPE yyerror;
%}

%%

[0-9]+ {yylval = atoi(yytext); return NUM;}
[-+*/()] { return yytext[0];}
[ \t] {}
\n {return 0;}
. {return yytext[0];}

%%

int yywrap(){
 return 1;
}

// lex prg2b.l
// yacc -d prg2b.y
// gcc y.tab.c lex.yy.c -o prg2b -ll
// ./prg2b

// i/p 

/* Enter the Expression nigga : 
(4+5)*2-10/5The Result is 16
Valid...
*/
