%{
#include<stdio.h>
int pos_int=0,neg_int=0,pos_frac=0,neg_frac=0;
%}

%%

-[0-9]+\.[0-9]+\/-[0-9]+\.[0-9]+ {}
-[0-9]+\.[0-9]+\/-[0-9]+ {neg_frac++;} //-x.y/z
-[0-9]+/-[0-9]+\.[0-9]+ {neg_frac++;} // -x/y.z
-[0-9]+\/[0-9]+ { neg_frac++; } // -x/y
-[0-9]+\.[0-9]+ { neg_frac++; } // -x.y

[+]?[0-9]+\.[0-9]+\/[+]?[0-9]+\.[0-9]+ {pos_frac++;} // x.a/y.b
[+]?[0-9]+\.[0-9]+ {pos_frac++;} // x.y
[0-9]+\/[0-9]+       { pos_frac++; } // x/y

[+]?([0-9]+) {pos_int++;}
-([0-9]+) {neg_int++;}

"#" {return 0;}
. {}

%%

int yywrap(){
return 1;
}

int main(){
	printf("Enter the numbers : \n");
	yylex();
	printf("\nTotal number of negative fractions = %d\n",neg_frac);
	printf("Total number of positive fractions = %d\n",pos_frac);
	printf("Total number of negative numbers = %d\n",neg_int);
	printf("Total number of positive numbers = %d\n",pos_int);
	return 0;
}


// lex prg2a.l
// gcc lex.yy.c -o prg2a -ll
// ./prg2a

// i/p
/* Enter the numbers : 
12 -34 0.5 -0.25 7/3 -1/2 3.14 -4.56 #
Total number of negative fractions = 3
Total number of positive fractions = 3
Total number of negative numbers = 1
Total number of positive numbers = 1
*/
