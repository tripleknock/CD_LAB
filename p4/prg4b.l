%{
#include "y.tab.h"
%}

%%

"if"        { return IF; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LF; }
"}"         { return RF; }
"<="        { return LE; }
">="        { return GE; }
"=="        { return EQ; }
"!="        { return NEQ; }
"<"         { return '<'; }
">"         { return '>'; }
"="         { return '='; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }

[a-zA-Z_][a-zA-Z0-9_]*  { return ALPHA; }
[0-9]+                  { return NUM; }

[ \t\n]                 { }

"#"                    { return 0; }
.                      {  }

%%

int yywrap() {
    return 1;
}

// lex prg4b.l
// yacc -d prg4b.y
// gcc lex.yy.c y.tab.c -o prg4b -ll
// ./prg4b

// i/p 

/* Enter an expression:
if(x < 5) {
    if(y >= 2)
        a;
}
Number of if loops are 2
*/
