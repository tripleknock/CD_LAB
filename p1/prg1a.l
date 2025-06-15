%{
#include<stdio.h>
int lines =1,chars=0,words=0,spaces=0;
%}

%%

[ \t] {spaces += (yytext[0]=='\t') ? 4 : 1;}
\n {lines++;}
[a-zA-Z0-9]+ {words++;chars+=yyleng;}
. {chars++;}
'#' {return 0;}

%%

int yywrap(){
	return 1;
}

int main()
{
	printf("Enter the paragraph : \n");
	yylex();
	printf("\nNumber of lines = %d\n",lines);
	printf("Number of spaces = %d\n",spaces);
	printf("Number of words = %d\n",words);
	printf("Number of characters = %d\n",chars);
	return 0;
	
}

// lex prg1a.l
// gcc lex.yy.c -o prg1a -ll
// ./prg1a

// i/p
/*This is
a test paragraph # */
