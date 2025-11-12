%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(const char *s);
%}


%union {
    double val;
}

%token <val> NUMBER
%token SIN, COS, TAN, LOG, EXP, SQRT, ASIN, ACOS, ATAN, ABS, POW

%type <val> expr

%left '+' '-'       
%left '*' '/'
%right UMINUS   

%%
lines:
    lines expr '\n'   { printf("= %g\n", $2); }
    | lines '\n'      /* Allow empty lines */
    | /* empty */
    ;

expr:
    NUMBER                { $$ = $1; }
    | expr '+' expr       { $$ = $1 + $3; }
    | expr '-' expr       { $$ = $1 - $3; }
    | expr '*' expr       { $$ = $1 * $3; }
    | expr '/' expr       {
                            if ($3 == 0.0) {
                                yyerror("Error: Division by zero");
                                $$ = 0.0;
                            } else {
                                $$ = $1 / $3;
                            }
                          }
    | '(' expr ')'        { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | SIN '(' expr ')'    { $$ = sin($3); }
    | COS '(' expr ')'    { $$ = cos($3); }
    | TAN '(' expr ')'    { $$ = tan($3); }
    | LOG '(' expr ')'    {
                            if ($3 <= 0.0) {
                                yyerror("Error: Logarithm of non-positive number");
                                $$ = 0.0;
                            } else {
                                $$ = log10($3); 
                            }
                          }
    | EXP '(' expr ')'    { $$ = exp($3); } 
    | SQRT '(' expr ')'   {
                            if ($3 < 0.0) {
                                yyerror("Error: Square root of negative number");
                                $$ = 0.0;
                            } else {
                                $$ = sqrt($3);
                            }
                          }
    | ASIN '(' expr ')'   { $$ = asin($3); }
    | ACOS '(' expr ')'   { $$ = acos($3); }
    | ATAN '(' expr ')'   { $$ = atan($3); }
    | ABS '(' expr ')'    { $$ = fabs($3); }
    | POW '(' expr ',' expr ')' { $$ = pow($3, $5); } /* x^y */
    ;

%%

int main() {
    printf("Scientific Calculator (e.g., pow(2, 3) + sin(0.5))\n");
    printf("Enter calculation (or Ctrl+D to exit):\n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
/*
yacc -d lab_4.y
lex lab_4.l
gcc y.tab.c lex.yy.c -o scicalc -lm
./scicalc
*/
