/*

Including the neccessary headers. 

*/
%{

    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(const char* s);
    int yylex(void);
    

%}

/*

    Neccessary tokens. 

*/

%token DELETE FROM IDENTIFIER WHERE CONDITIONAL_OP RELATIONAL_OP SEMICOLON TEXT NUMBER NEWLINE AS NOT



%%

/*  Grammar Rules: 


    line : delete

    delete : DELETE from | error 

    from : 	FROM table where | FROM table semicolon NEWLINE | error 

    table : IDENTIFIER | IDENTIFIER AS IDENTIFIER | error 

    where: WHERE condition semicolon NEWLINE | error 

    condition : IDENTIFIER RELATIONAL_OP IDENTIFIER 

	    | IDENTIFIER RELATIONAL_OP TEXT 

	    | IDENTIFIER RELATIONAL_OP NUMBER 

	    | IDENTIFIER RELATIONAL_OP IDENTIFIER CONDITIONAL_OP condition

	    | IDENTIFIER RELATIONAL_OP TEXT CONDITIONAL_OP condition

	    | IDENTIFIER RELATIONAL_OP NUMBER CONDITIONAL_OP condition

	    | NUMBER RELATIONAL_OP NUMBER 

	    | NUMBER RELATIONAL_OP NUMBER CONDITIONAL_OP condition 

	    | NOT condition

	    | error 




*/

/*
    Initial Rule. 
*/
line: delete {printf("Syntax Correct\n"); 

    return 0;

};



delete : DELETE from | error {yyerror(" : Did you mean \"DELETE\" ? \n"); return 1; };

/*
    Covering two cases of deletion from a single table. 
    1. When a condition is specified using a WHERE clause.
    2. When no condition is specified. 
*/

from : FROM table where | FROM table semicolon NEWLINE |  error {yyerror("   : Did you mean \" FROM \" ? \n"); return 1; }; 

/*
    Covering two cases of table name:
    1. Without any alias.
    2. With an alias using AS keyword. 

*/

table : IDENTIFIER | IDENTIFIER AS IDENTIFIER | error {yyerror(" : table name is missing.\n"); return 1; };



where : WHERE condition semicolon NEWLINE | 
error {yyerror(" : Did you mean \" WHERE \" ? \n"); return 1; };

/*
    Covering the cases of different conditions that can be specified.
    
    1 - 4 are self explainatory. 
    5 - 8 covers the cases where rules [1,4] are appended with an conditional operator and another condition.
    9 covers the case where we can apply NOT operator in front of a conditional statement. 

*/

condition : IDENTIFIER RELATIONAL_OP IDENTIFIER |
            IDENTIFIER RELATIONAL_OP TEXT |
            IDENTIFIER RELATIONAL_OP NUMBER |
            NUMBER RELATIONAL_OP NUMBER |   
            IDENTIFIER RELATIONAL_OP IDENTIFIER CONDITIONAL_OP condition | 
            IDENTIFIER RELATIONAL_OP TEXT CONDITIONAL_OP condition |
            IDENTIFIER RELATIONAL_OP NUMBER CONDITIONAL_OP condition |
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
    return 1; 
}