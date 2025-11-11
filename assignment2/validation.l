%{
    #include "y.tab.h"

%}



%%

[0-9]+ {

    return NUMBER;

}

\n {

    return 0;

}
[\t ] ;
.   {
        return yytext[0];
    
}


%%

int yywrap(void){

    return 1; 

}

