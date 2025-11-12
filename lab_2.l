%{
#include <stdio.h>
#include <string.h>
int line_num = 1;
extern FILE *yyin;
%}
%%
"int"|"float"|"char"|"double"|"if"|"else"|"while"|"for"|"return" {
 printf("KEYWORD\t\t%s\t(line %d)\n", yytext, line_num);
}
[a-zA-Z_][a-zA-Z0-9_]* {
 printf("IDENTIFIER\t%s\t(line %d)\n", yytext, line_num);
}
[0-9]+(\.[0-9]+)? {
 printf("NUMBER\t\t%s\t(line %d)\n", yytext, line_num);
}
"=="|"="|"+"|"-"|"*"|"/"|"<"|">" {
 printf("OPERATOR\t%s\t(line %d)\n", yytext, line_num);
}
[(){};,.\[\]] {
 printf("DELIMITER\t%s\t(line %d)\n", yytext, line_num);
}
\"([^\\\"]|\\.)*\" {
 printf("STRING\t\t%s\t(line %d)\n", yytext, line_num);
}
"//".* { /* ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+\/ { /* ignore multi-line comments */ }
[ \t]+ { /* ignore whitespace */ }
\n { line_num++; }
^#.* {printf("PREPROCESSOR: \t%s\n", yytext);}
. { printf("UNKNOWN\t\t%s\t(line %d)\n", yytext, line_num); }
%%
int main(int argc, char *argv[]) {
 if (argc > 1) {
 FILE *f = fopen(argv[1], "r");
 if (!f) {
 perror("Cannot open file");
 return 1;
 }
 yyin = f;
 }
 yylex();
 return 0;
}

/*
lex lab_2.l
gcc lex.yy.c -ll
./a.out
*/
