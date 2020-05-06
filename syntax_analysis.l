%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "syntax_analysis.tab.h"
%}

delim [ \t \n]
ws    {delim}+
letter [A-Za-z]
digit [0-9]
id {letter}({letter}|{digit})*
number {digit}+

%%
"int"|"float"|"char*"|"char"|"double" {return(TYPE);}
"void" {return(VOID);}
"while" {return(WHILE);}
"if" {return(IF);}
"break" {return(BREAK);}
"continue" {return(CONTINUE);}
"for" {return(FOR);}
"else" {return(ELSE);}
"return" {return(RETURN);}
"main" {return(MAIN);}
"while" {return(WHILE);}
"<"|">"|"=="|">="|"<="|"<>" {return(COMPAREOP);}
"+"|"-"|"*"|"/"|"*" {return(CALCULOP);}
"++"|"--" {return(AUTOCHANGEOP);}
"=" {return(EQUALOP);}
"(" {return(LB);}
"[" {return(LBB);}
"{" {return(LBBB);}
")" {return(RB);}
"]" {return(RBB);}
"}" {return(RBBB);}
";" {return(SEMI);}
"," {return(COMMA);}
{id} {return (ID);}
{number} {return (NUMBER);}
{ws} {;}
%%

int yywrap(){
    return 1;
    /*
%token TYPE VOID WHILE IF BREAK CONTINUE FOR ELSE RETURN MAIN WHILE COMPAREOP CALCULOP EQUALOP LB LBB LBBB RB RBB RBBB SEMI COMMA ID NUMBER
    */
}




