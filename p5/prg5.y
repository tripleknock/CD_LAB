%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(const char *s);
int yylex(void);
int var_count=0;
%}
%token INT FLOAT CHAR DOUBLE IDENTIFIER NUM
%%

program : definition ;

definition : 
	| definition ';'
	| definition definition ';' ;

definition : type var_list ;

type : INT | FLOAT | CHAR | DOUBLE ;

var_list : var
	| var_list ',' var ;

var : identifier
	| identifier '[' ']'
	| identifier '[' NUM ']' ;

identifier : 
	IDENTIFIER {var_count++;} ;

%%
void yyerror(const char *s){
	fprintf(stderr,"Invalid %s",s);
	exit(1);
}
int main(){
	printf("Enter the declarations\n");
	yyparse();
	printf("Total number of variables = %d",var_count);
	return 0;
}

// lex prg5.l
// yacc -d prg5.y
// gcc lex.yy.c y.tab.c -o prg5 -ll
// ./prg5
