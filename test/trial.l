%{

    #include <stdio.h>


%}


%%


"DELETE" printf("%s\n", yytext);

"FROM"   printf("%s\n", yytext);

"WHERE"  printf("%s\n", yytext);

"AND"|"OR"|"NOT" printf("%s\n", yytext);

"LIKE" | "IN"    printf("%s\n", yytext); 

[0-9]+     printf("%s\n", yytext); 

[\"](.)+[\"] printf("%s\n", yytext); 

[\'](.)+[\'] printf("%s\n", yytext); 

"<"|">"|"<="|">="|"="|"!="     printf("%s\n", yytext); 

[a-zA-Z0-9_$][a-zA-Z_$][a-zA-Z0-9_$]+ printf("%s\n", yytext); 

[a-zA-Z0-9_$][a-zA-Z_$][a-zA-Z0-9_$]*["."][a-zA-Z0-9_$]+ {

    printf(" Identifier is :%s\n", yytext);  
}


\n          return 0;
";"         return 0;

[ \t]|" "  ;  

.           return *yytext;

%%

int main(void){

    yylex(); 



}

int yywrap(void){

    return 1; 

}