%{
#include <stdio.h>
#include <ctype.h>
int mode = 0;
int isStartOfSentence = 1;
%}

%%
[a-zA-Z] {
    switch(mode) {
        case 1:
            printf("%c", toupper(yytext[0]));
            isStartOfSentence = 0; 
            break;
            
        case 2: 
            printf("%c", tolower(yytext[0]));
            isStartOfSentence = 0; 
            break;
            
        case 3: 
            if (isStartOfSentence) {
                printf("%c", toupper(yytext[0]));
                isStartOfSentence = 0; 
            } else {
                printf("%c", tolower(yytext[0]));
            }
            break;
            
        case 4: 
        default:
            if (islower(yytext[0])) {
                printf("%c", toupper(yytext[0]));
            } else {
                printf("%c", tolower(yytext[0]));
            }
            isStartOfSentence = 0; 
            break;
    }
}
[.?!] {
    ECHO; 
    isStartOfSentence = 1; 
}
[ \t\n,;:]+ {
    ECHO;
}
. {
    ECHO;
}

%%

int main() {
    printf("Select case conversion mode:\n");
    printf("  1: ALL UPPER CASE\n");
    printf("  2: all lower case\n");
    printf("  3: Sentence case\n");
    printf("  4: Toggle Case\n");
    printf("Enter mode (1-4): ");
    scanf("%d", &mode);
    getchar(); 
    printf("\nEnter text to convert (Press Ctrl+D when done):\n");
    yylex();
    printf("\nConversion complete.\n");
    return 0;
}
int yywrap() {
    return 1;
}

/*
lex lab_1_5.l
gcc lex.yy.c
./a.out
*/
