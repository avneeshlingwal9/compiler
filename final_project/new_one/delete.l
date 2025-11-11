%{
    #include <stdio.h>
    #include "y.tab.h"

%}


%%

"DELETE" return DELETE;

"FROM"   return FROM;

"WHERE" return WHERE;

"AS"    return AS; 

"AND"|"OR"|"NOT" return CONDITIONAL_OP;

"LIKE" | "IN"    return RELATIONAL_OP;

[0-9]+     return NUMBER;

[\"](.)+[\"] return TEXT;

[\'](.)+[\'] return TEXT;

"<"         return RELATIONAL_OP;
">"         return RELATIONAL_OP;
"<="        return RELATIONAL_OP;
">="        return RELATIONAL_OP;
"="        return RELATIONAL_OP;
"!="        return RELATIONAL_OP;

";"         return SEMICOLON;

([a-zA-Z]+)|([a-zA-Z0-9_$][a-zA-Z_$][a-zA-Z0-9_$]+) return IDENTIFIER;

(([a-zA-Z]+)|([a-zA-Z0-9_$][a-zA-Z_$][a-zA-Z0-9_$]*))["."][a-zA-Z0-9_$]+  return IDENTIFIER; 


\n          return NEWLINE;


[ \t]|" "  ;  

.           return *yytext;

%%

