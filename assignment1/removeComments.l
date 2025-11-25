%{
#include <stdio.h>
int singleLine = 0 , multiLine = 0;
%}

%%

\"(\\\"|[^"])*\" {

    fprintf(yyout , "%s" , yytext);
}

\/\*(([^*]|[\r\n])|(\*+([^\*\/]|[\r\n])))*\*+\/ {

    printf("Multiline comments: %s\n",yytext); 


    multiLine++;


}
\/\/.* {


    singleLine++;


}


\n {
    fprintf(yyout , "\n");
}

. {
    fprintf(yyout , "%s", yytext); 
}

%%

int main(){

    yyin = fopen("comments.cpp" , "r"); 

    yyout = fopen("commentFree.cpp" , "w+"); 


    yylex(); 


    printf("The number of single line comments in the file are: %d \n" , singleLine);
    printf("The number of multiline comments are: %d\n" , multiLine);


}

int yywrap(void){

    return 1; 
}
