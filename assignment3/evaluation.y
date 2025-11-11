%{
    
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void); 

    void yyerror(const char *s); 



%}

%union {

    int val; 
}

%token <val> NUMBER

%token NEWLINE

%type <val> E

%left '+' '-'

%left '*' '/'

%start line 

%%

line : E NEWLINE {

    printf("The result is %d\n", $1);

    YYACCEPT;
}

| NEWLINE {     
    YYACCEPT;
}
;



E : E '+' E     {$$ = $1 + $3;}

    | E '-' E  {$$ = $1 - $3;}

    | E '*' E { $$ = $1 * $3;}

    | E '/' E  {

        if($3 == 0){

            yyerror("Division by zero."); 

            YYABORT; 

        }

        else{

            $$ = $1 / $3;

        }

    }

    | '(' E ')' {$$ = $2;}

    | NUMBER  {$$ = $1;}


    ; 



%%


int main(void){

    printf("Enter the arithmetic expression: \n"); 

    if(yyparse() == 0){

        printf("Parsing complete.\n"); 

    }

    else{

        printf("Invalid expression.\n"); 

    }


    return 0;

}

void yyerror(const char* s){

    printf("The error is %s\n", s); 

}