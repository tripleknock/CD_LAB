%{
#include <stdio.h>
#include <stdlib.h>

int single = 0, multi = 0, multilines = 0;
extern FILE *yyin, *yyout;
%}

%%

\/\/.* {
    single++;
}

\/\*([^*]|\*+[^*/])*\*+\/ {
    multi++;
    for (int i = 0; i < yyleng; i++) {
        if (yytext[i] == '\n') multilines++;
    }
}

.|\n {
    fputc(yytext[0], yyout);
}

%%

int yywrap() {
    return 1;
}

int main() {
    yyin = fopen("inp.txt", "r");
    if (!yyin) {
        perror("Error opening input file");
        exit(1);
    }

    yyout = fopen("out.txt", "w");
    if (!yyout) {
        perror("Error opening output file");
        fclose(yyin);
        exit(1);
    }

    yylex();

    printf("Number of single line comments = %d\n", single);
    printf("Number of multi line comments = %d\n", multi);
    printf("Number of lines in multi line comments = %d\n", multilines);

    fclose(yyin);
    fclose(yyout);
    return 0;
}


// lex prg3a.l
// gcc lex.yy.c -o prg3a -ll
// ./prg3a
