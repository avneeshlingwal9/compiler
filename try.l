%{
    #include <stdio.h>
    int singleLine = 0 ; 
    
%}

%%
\"[^\"]*\" ; 
[//][^\n]*  {

    singleLine++; 
}

. ;

\n ;





%%

int main(){

   yyin = fopen("comments.cpp", "r"); 

   yylex(); 

   printf("The number of single line comments are: %d\n", singleLine);

    return 0;
}

int yywrap(){

    return 1; 
}