digit [0-9]
alphabets [a-zA-Z]
identifier ({alphabets}|{digit}|"_"|"$")

%{
    #include <stdio.h>
    #include "y.tab.h"
    
%}


%%

"DELETE" return DELETE;

"FROM"   return FROM;

"WHERE" return WHERE;

"AS"    return AS; 

"AND"|"OR" return CONDITIONAL_OP;

"NOT" return NOT; 

"LIKE"|"IN"    return RELATIONAL_OP;

{digit}+     return NUMBER;

[\"](.)+[\"] return TEXT;

[\'](.)+[\'] return TEXT;

"<"         return RELATIONAL_OP;
">"         return RELATIONAL_OP;
"<="        return RELATIONAL_OP;
">="        return RELATIONAL_OP;
"="        return RELATIONAL_OP;
"!="        return RELATIONAL_OP;

";"         return SEMICOLON;

({alphabets}+)|({identifier})[a-zA-Z_$]({identifier}+) return IDENTIFIER;

(({alphabets}+)|({identifier}[a-zA-Z_$]{identifier}*))["."]{identifier}+  return IDENTIFIER; 


\n          return NEWLINE;


[ \t]|" "  ;  

.           return *yytext;

%%

