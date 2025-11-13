%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(const char* s);
    int yylex(void);
    

%}


%token DELETE FROM IDENTIFIER WHERE CONDITIONAL_OP RELATIONAL_OP SEMICOLON TEXT NUMBER NEWLINE AS NOT



%%



line: delete {printf("Syntax Correct\n"); 
    return 0;
};

delete : DELETE from | error {yyerror(" : Did you mean \"DELETE\" ? \n"); return 1; };

from : FROM table where | FROM table semicolon NEWLINE |  error {yyerror("   : Did you mean \" FROM \" ? \n"); return 1; }; 

table : IDENTIFIER | IDENTIFIER AS IDENTIFIER | error {yyerror(" : table name is missing.\n"); return 1; };

where : WHERE condition semicolon NEWLINE | 
error {yyerror(" : Did you mean \" WHERE \" ? \n"); return 1; };

condition : IDENTIFIER RELATIONAL_OP IDENTIFIER |
            IDENTIFIER RELATIONAL_OP TEXT |
            IDENTIFIER RELATIONAL_OP NUMBER |
            IDENTIFIER RELATIONAL_OP IDENTIFIER CONDITIONAL_OP condition | 
            IDENTIFIER RELATIONAL_OP TEXT CONDITIONAL_OP condition |
            IDENTIFIER RELATIONAL_OP NUMBER CONDITIONAL_OP condition |
            NUMBER RELATIONAL_OP NUMBER |
            NUMBER RELATIONAL_OP NUMBER CONDITIONAL_OP condition | 
            NOT condition | 

            error {
                
                yyerror(" : Incorrect Condtion \n");
                return 1; 
            };

semicolon : SEMICOLON | error {yyerror(" : Missing semicolon \";\" \n"); return 1; };


%%

int main(void){

    printf("mysql>");
    yyparse();
    return 0; 

}

void yyerror(const char* s){

    printf("Error is %s\n", s); 

}

int yywrap(){
    return 0; 
}