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

%token DELETE FROM IDENTIFIER WHERE LIKE RELATIONAL_OP SEMICOLON TEXT NUMBER NEWLINE AS NOT IN IS NULL_ BETWEEN AND OR

%left OR 
%left AND


%%

/*  Grammar Rules: 


    line : delete

    delete : DELETE from | error 

    from : 	FROM table where | FROM table semicolon NEWLINE | error 

    table : IDENTIFIER | IDENTIFIER AS IDENTIFIER | error 

    where: WHERE conditions semicolon NEWLINE | error 

    conditions : condition | condition AND condition | condition OR condition |  error 

    condition : identifier RELATIONAL_OP NUMBER |

            identifier RELATIONAL_OP TEXT |

            identifier RELATIONAL_OP identifier |  

            NOT condition | 

            identifier IS NULL_ | 

            identifier IS NOT NULL_ | 

            identifier LIKE TEXT | 
            identifier BETWEEN NUMBER AND NUMBER |

            identifier BETWEEN TEXT AND TEXT |

            identifier IN '('values')'|

            identifier NOT IN '('values')'

    identifier : IDENTIFIER | 
                
            IDENTIFIER'.'IDENTIFIER 

    
    values: value | value ',' values  

    value : NUMBER | TEXT 

    semicolon : SEMICOLON | error
    




*/

/*
    Initial Rule. 
*/
line: delete {printf("Syntax Correct\n"); return 0;};



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


where : WHERE conditions semicolon NEWLINE | error {yyerror(" : Did you mean \" WHERE \" ? \n"); return 1; };

/* Compound conditions  */

conditions : condition | condition AND condition | condition OR condition |  error {yyerror(": Condition issue\n"); return 1; };

/* 
    Singular condition statement. 

*/
condition : identifier RELATIONAL_OP NUMBER |
            identifier RELATIONAL_OP TEXT |
            identifier RELATIONAL_OP identifier |  
            NOT condition | 
            identifier IS NULL_ | 
            identifier IS NOT NULL_ | 
            identifier LIKE TEXT | 
            identifier BETWEEN NUMBER AND NUMBER |
            identifier BETWEEN TEXT AND TEXT |
            identifier IN '('values')'|
            identifier NOT IN '('values')'
            ;


/*

    Handling the case of table_name.column_name

*/

identifier : IDENTIFIER | IDENTIFIER'.'IDENTIFIER ;

/* List of values for IN. */

values: value | value ',' values ; 

/* Singular value in list of values. */

value : NUMBER | TEXT ; 


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
