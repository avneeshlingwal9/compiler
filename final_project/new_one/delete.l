
/* Defining neccessary definitions. */
/*  So only digit cannot be an identifier, must have any other character after it, but identifier can be of only alphabet and $ is omitted, because it is deprecated to use $ can first letter of identifier. */


digit [0-9]
alphabets [a-zA-Z]
alphanum ({alphabets}|{digit}|"_"|"$")
identifier ({digit}[a-zA-Z_$]|[a-zA-Z_])({alphanum}*) 

%{
    #include <stdio.h>
    #include "y.tab.h"
    
%}


%%

(d|D)(e|E)(l|L)(e|E)(t|T)(e|E)  return DELETE;

(f|F)(r|R)(o|O)(m|M)   return FROM;

(w|W)(h|H)(e|E)(r|R)(e|E) return WHERE;

(a|A)(s|S)    return AS; 

(a|A)(n|N)(d|D)|(o|O)(r|R) return CONDITIONAL_OP;  /* NOT is not included, because it is a unary operator and to handle the case where the 
    
                                conditions can be specified as (NOT condition).  */


(n|N)(o|O)(t|T) return NOT; 

(l|L)(i|I)(k|K)(e|E)|(I|i)(N|n)    return RELATIONAL_OP;

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

{identifier} return IDENTIFIER; 



{identifier}["."]{identifier}  return IDENTIFIER; // To handle the case where table_name.column_name


\n          return NEWLINE;


[ \t]|" "  ;  

.           return *yytext;

%%

