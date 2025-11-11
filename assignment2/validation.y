%{
    #include <stdio.h>
    void yyerror(const char* s);
    int yylex(void);

%}


%token NUMBER 
%left '+' '-'
%left '*' '/'


%%

E : E '+' E

    | E '-' E 

    | E '*' E 

    | E '/' E   

    | '(' E ')'

    | NUMBER 

    ;




%%

int main(void){

    printf("Enter the arithmetic expression: \n"); 

    if(yyparse() == 0){

        printf("Expression is valid.\n"); 

    }

    else{

        printf("Expression is not valid.\n"); 

    }

    return 0; 

}

void yyerror(const char* s){

    printf("Error is %s\n", s); 

}

