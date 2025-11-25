/* Defining neccessary definitions. */
/*  So only digit cannot be an identifier, must have any other character after it, but identifier can be of only alphabet. */


digit [0-9]
alphabets [a-zA-Z]
alphanum ({alphabets}|{digit}|"_"|"$")
identifier ({digit}[a-zA-Z_$]|[a-zA-Z_$])({alphanum}*) 



%{
    #include <stdio.h>
    #include "y.tab.h"
     
%}




%%

[dD][eE][lL][eE][tT][eE]  return DELETE;

[fF][rR][oO][mM]   return FROM;

[wW][hH][eE][rR][eE] return WHERE;

[aA][sS]    return AS; 

[aA][nN][dD]  return AND;

[oO][rR]    return OR;


[nN][oO][tT] return NOT; 

[lL][iI][kK][eE]    return LIKE;

[Ii][Nn]            return IN; 

[Ii][Ss]            return IS;

[Nn][uU][lL][lL]    return NULL_; 

[bB][eE][tT][wW][Ee][Ee][Nn] return BETWEEN; 

[-]*{digit}+     return NUMBER; // Modified for negative numbers.

\`[^\`]+\`     return IDENTIFIER; // If it is quoted, then anything inside it can be identifier. 

\"(\\\"|[^"])*\" return TEXT; // Modified regex.

\'(\\\'|[^'])*\' return TEXT; // Modified regex. 

"<"        return RELATIONAL_OP;
">"        return RELATIONAL_OP;
"<="       return RELATIONAL_OP;
">="       return RELATIONAL_OP;
"="        return RELATIONAL_OP;
"!="       return RELATIONAL_OP;

";"        return SEMICOLON;

{identifier} return IDENTIFIER; 

\n          return NEWLINE;


[ \t]  ;  

.           return *yytext;

%%


