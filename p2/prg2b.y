%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
void yyerror(const char* s);
int yylex(void);

%}

%token NUM
%left '-' '+'
%left '/' '*'

%%

S : E { printf("The Result is %d\n",$1);}
  ;

E : E'+'E {$$ = $1 + $3;}
  | E'-'E {$$ = $1 - $3;}
| E'*'E {$$ = $1 * $3;}
| E'/'E {if($3 == 0) {yyerror("Division by zero");} else {$$ = $1 / $3;}}
| '-'E {$$ = -$2;}
| '('E')' {$$ = $2;}
| NUM {$$ = $1;}
	;

%%

void yyerror(const char *s){
	fprintf(stderr, "Invalid %s",s);
	exit(1);
}

int main(){
	printf("Enter the Expression nigga : \n");
	yyparse();
	printf("Valid...\n");
	return 0;
}

// lex expr.l
// yacc -d expr.y
// gcc y.tab.c lex.yy.c -o expr -ll
// ./expr




