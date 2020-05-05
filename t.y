%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

%}
%token TYPE VOID WHILE IF BREAK CONTINUE FOR ELSE RETURN MAIN WHILE COMPAREOP CALCULOP EQUALOP LB LBB LBBB RB RBB RBBB SEMI COMMA ID NUMBER
%union{
  char* str;
  char c;
  int i;
}
%%
program : program fun {printf("program-->program fun\n");}
        | fun {printf("program-->fun\n");}
        |
        ;
fun     : TYPE ID LB arguments_list RB LBBB code_block return_statement RBBB {printf("-->fun with return type\n");}
        | VOID ID LB arguments_list RB LBBB code_block RBBB {printf("-->fun with void type\n");}
        |fun fun {printf("-->fun fun\n");}
        |
        ;
arguments_list : arguments_list arguments_list{printf("-->double arguments_list\n");}
               | TYPE ID COMMA {printf("--> TYPE ID ,\n");}
               | TYPE ID {printf("TYPE ID\n");}
               |
               ;
return_statement : RETURN ID SEMI{printf("-->return");}
code_block       : code_block code_block {printf("-->double code_block\n");}
                 | TYPE ID EQUALOP NUMBER SEMI{printf("-->fuzhi_code\n");}      
                 |
                 ;
id_num           : ID {}
                 | NUMBER {}
                 |
                 ;  
if_statements : IF LB id_num COMPAREOP id_num RB LBBB code_block RBBB {printf("-->if_statement\n");}
              |
              ;
else_statement : ELSE LBBB code_block RBBB {printf("-->else_statement\n");}
               |
               ;
while_statement : WHILE LB id_num COMPAREOP id_num RB LBBB code_block RBBB {printf("-->while_statement\n");}
		|
		;
for_statements : FOR LB    

%%
int main(int argc, char* argv[]){
extern FILE* yyin;    
yyin = stdin;
    printf("Compliing...\n");
    if(yyparse()==1){
      printf("Parse Error\n");
      exit(1);
    }
    printf("yyparse() completed successfully\n");
    return 0;
}

int yyerror(char *s){
    printf("ERROR:%s",s);
    return 1;
}
