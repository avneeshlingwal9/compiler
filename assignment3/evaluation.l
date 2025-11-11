%{
    
    #include <stdlib.h>
    #include "y.tab.h"


%}

%%

[0-9]+ {

    yylval.val = atoi(yytext);

    return NUMBER;

}

\n {

    return NEWLINE;

}

[\t ] ;

.   {

    return yytext[0]; 
}

%%

int yywrap(void){

    return 1; 

}