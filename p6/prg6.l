%{
#include "y.tab.h"
%}

%%

[a-z]           { yylval.sym = yytext[0]; return LETTER; }
[0-9]           { yylval.sym = yytext[0]; return NUMBER; }
[ \t\n]+        { /* skip whitespace */ }
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}

//yacc -d prg6.y
//lex prg6.l
//gcc lex.yy.c y.tab.c -o prg6 -ll
//./prg6

// i/p 
/* Enter the Expression (end with `;`):
a = b + c * d;

Three-Address Code:
T = c * d
U = b + T
a = U

Quadruple Representation:
0	*	c	d	T
1	+	b	T	U
2	=	U	_	a

Triple Representation:
0	*	c	d
1	+	b	T
2	=	a	U

*/
