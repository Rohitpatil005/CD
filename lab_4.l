%{
#include "y.tab.h"
#include <stdlib.h> 
#include <string.h> 
void yyerror(char *);
%}
NUMBER   ([0-9]+(\.[0-9]*)?|\.[0-9]+)

IDENT    [a-zA-Z]+

%%
{IDENT} {
    if (strcasecmp(yytext, "sin") == 0) return SIN;
    if (strcasecmp(yytext, "cos") == 0) return COS;
    if (strcasecmp(yytext, "tan") == 0) return TAN;
    if (strcasecmp(yytext, "log") == 0) return LOG;
    if (strcasecmp(yytext, "exp") == 0) return EXP;
    if (strcasecmp(yytext, "sqrt") == 0) return SQRT;
    if (strcasecmp(yytext, "asin") == 0) return ASIN;
    if (strcasecmp(yytext, "acos") == 0) return ACOS;
    if (strcasecmp(yytext, "atan") == 0) return ATAN;
    if (strcasecmp(yytext, "abs") == 0) return ABS;
    if (strcasecmp(yytext, "pow") == 0) return POW;
    yyerror("Error: Unknown function or identifier");
    return yytext[0]; 
}

{NUMBER} {
    yylval.val = atof(yytext);
    return NUMBER;
}
[ \t]     {}
\n        { return '\n';}
.         { 
    return yytext[0]; 
}

%%
int yywrap() {
    return 1; 
}
