%{
#include "y.tab.h"
%}

%%

for             { return FOR; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LF; }
"}"             { return RF; }
[a-zA-Z_][a-zA-Z0-9_]*   { return ALPHA; }
[0-9]+          { return NUM; }
"++"            { return INC; }
"--"            { return DEC; }
"+="            { return ADDEQ; }
"-="            { return SUBEQ; }
"=="            { return EQ; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return '<'; }
">"             { return '>'; }
"="             { return '='; }
";"             { return ';'; }
[ \t\n]         { }
.               { return yytext[0]; }

%%

//lex prg3b.l
// yacc -d prg3b.y
// gcc lex.yy.c y.tab.c -o prg3b -ll
// ./prg3b
