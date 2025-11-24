/* Defining neccessary definitions. */
/*  So only digit cannot be an identifier, must have any other character after it, but identifier can be of only alphabet. */


digit [0-9]
alphabets [a-zA-Z]
alphanum ({alphabets}|{digit}|"_"|"$")
identifier ({digit}[a-zA-Z_$]|[a-zA-Z_$])({alphanum}*) 



%{
    #include <stdio.h>
    #include "y.tab.h"

    void showToken(const char *s){

    printf("Lexeme for token %s is %s\n", s, yytext); 

}
    
    
%}




%%

[dD][eE][lL][eE][tT][eE]  {showToken("DELETE");return DELETE;};

[fF][rR][oO][mM]   {showToken("FROM");return FROM;}

[wW][hH][eE][rR][eE] {showToken("WHERE");return WHERE;}

[aA][sS]    {showToken("AS");return AS;} 

[aA][nN][dD]  {showToken("AND");return AND;}

[oO][rR] {showToken("OR");return OR;} 


[nN][oO][tT] {showToken("NOT");return NOT;} 

[lL][iI][kK][eE]    {showToken("LIKE");return LIKE;}

[Ii][Nn]            {showToken("IN");return IN;} 

[Ii][Ss]            {showToken("IS");return IS;}

[Nn][uU][lL][lL]    {showToken("NULL");return NULL_;} 

[bB][eE][tT][wW][Ee][Ee][Nn] {showToken("BETWEEN");return BETWEEN;} 

[-]*{digit}+     {showToken("NUMBER");return NUMBER;} // Modified for negative numbers.

\`[^\`]+\`     {showToken("IDENTIFIER");return IDENTIFIER;} // If it is quoted, then anything inside it can be identifier. 

\"(\\\"|[^"])*\" {showToken("TEXT");return TEXT;} // Modified regex.

\'(\\\'|[^'])*\' {showToken("TEXT");return TEXT;} // Modified regex. 

"<"        {showToken("RELOP");return RELATIONAL_OP;}
">"        {showToken("RELOP");return RELATIONAL_OP;}
"<="       {showToken("RELOP");return RELATIONAL_OP;}
">="       {showToken("RELOP");return RELATIONAL_OP;}
"="        {showToken("RELOP");return RELATIONAL_OP;}
"!="       {showToken("RELOP");return RELATIONAL_OP;}

";"        {showToken("SEMICOLON");return SEMICOLON;}

{identifier} {showToken("IDENTIFIER");return IDENTIFIER;} 

\n          {showToken("NEWLINE");return NEWLINE;}


[ \t]  ;  

.           return *yytext;

%%


