%{
#include "y.tab.h"
%}
%%
a       { return 'a'; }
b       { return 'b'; }
c       { return 'c'; }
\n      { return 0; }
.       { return yytext[0]; }
%%
int yywrap() {
    return 1;
}

//lex prg1b.l
//yacc -d prg1b.y
//gcc lex.yy.c y.tab.c -o prg1b -ll
//./prg1b

// i/p
/* aaabbbbccc
   Invalid
  */
/* abbc
   Valid
*/
