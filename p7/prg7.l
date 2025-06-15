%{
#include "y.tab.h"
%}

%%

"int"|"void"|"char"|"float"|"double"      { return TYP; }
"return"                                  { return RETURN; }

[a-zA-Z_][a-zA-Z0-9_]*                    { return ID; }

"("                                       { return LP; }
")"                                       { return RP; }
"{"                                       { return LB; }
"}"                                       { return RB; }
";"                                       { return SC; }
","                                       { return CM; }
"="                                       { return EQ; }

"+"|"-"|"*"|"/"                            { return OP; }

[0-9]+                                    { return NUM; }

[ \t\n]+                                  { /* skip */ }

.                                         { /* skip */ }

%%

int yywrap(void) {
    return 1;
}

//lex prg7.l
// yacc -d prg7.y
// gcc lex.yy.c y.tab.c -o prg7 -ll
//./prg7

// i/p 
/* Enter C function code (end with #):
int sum(int a, int b) {
    int result = a + b;
    return result;
}
#
Function is syntactically correct.

*/
