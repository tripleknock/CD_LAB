%{
#include <stdio.h>
int key = 0, id = 0, op = 0;
extern FILE *yyin;
%}

%%

"int"|"float"|"double"|"if"|"for"|"else"|"while"|"switch"|"printf"|"scanf"|"exit"|"return"|"case"|"main" { key++; }

[a-zA-Z_][a-zA-Z0-9_]*          { id++; }

"=="|"!="|"<="|">="|"="          { op++; }
"++"|"--"                        { op++; }
"&&"|"||"                        { op++; }
"+"|"-"|"*"|"/"                  { op++; }
"<"|">"|"!"|"&"|"\\|"            { op++; }
"("|")"|"{"|"}"                  { op++; }


[0-9]+                          {  }

[ \t\n]+                        {  }

[;,]                            {  }

"#"                             { return 0; }
.                               {  }

%%

int yywrap() { return 1; }

int main() {
    yyin = fopen("eg.c", "r");
    if (!yyin) {
        perror("Cannot open file");
        return 1;
    }

    yylex();
    printf("Number of Keywords = %d\n", key);
    printf("Number of Identifiers = %d\n", id);
    printf("Number of operators = %d\n", op);

    fclose(yyin);
    return 0;
}

//lex prg4a.l
// gcc lex.yy.c -o prg4 -ll
// ./prg4
