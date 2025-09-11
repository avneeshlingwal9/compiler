%{
    #include <stdio.h>
    int numChar = 0, numLines = 0;
%}

%%

\n      { numChar++; numLines++; }   // newline
.       { numChar++; }               // any other char

%%

int main() {
    yylex();
    printf("# of lines is %d and # of chars is %d\n", numLines, numChar);
    return 0;
}

int yywrap() {
    return 1;
}
