%{
#include <stdio.h>
%}

%%
[0-9]      { printf("Digit: %s\n", yytext); }
[A-Za-z]   { printf("Character: %s\n", yytext); }
.          { printf("Unknown: %s\n", yytext); }
%%
int yywrap(){
	return 1;
	}
int main(int argc, char* argv[]){	
	printf("Enter input:");
	yylex();
	return 0;
	}
	
/* 
lex lab_1_1.l
gcc lex.yy.c
./a.out
*/
