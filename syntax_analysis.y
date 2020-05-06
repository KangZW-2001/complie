%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

%}
%token TYPE VOID WHILE IF BREAK CONTINUE FOR ELSE RETURN MAIN WHILE COMPAREOP CALCULOP EQUALOP LB LBB LBBB RB RBB RBBB SEMI COMMA ID NUMBER AUTOCHANGEOP
%%
program : program fun {printf("program-->program fun\n");}
        | fun {printf("program-->fun\n");}
        |
        ;
fun_name : ID
	 | MAIN
	 |
	 ;

fun     : TYPE fun_name LB arguments_list RB LBBB code_block return_statement RBBB {printf("fun -->TYPE fun_name LB arguments_list RB LBBB code_block return_statement RBBB \n");}
        | VOID fun_name LB arguments_list RB LBBB code_block return_statement RBBB {printf("fun -->VOID fun_name LB arguments_list RB LBBB code_block return_statement RBBB\n");}
        | 
        ;
arguments_list : arguments_list arguments_list{printf("arguments_list-->double arguments_list\n");}
               | TYPE ID COMMA {printf("arguments_list--> TYPE ID ,\n");}
               | TYPE ID {printf("arguments_list-->TYPE ID\n");}
               |
               ;
arguments_list_actual : arguments_list_actual arguments_list_actual {printf("arguments_list_actual-->double\n");}
		      | id_num COMMA {printf("arguments_list_actual-->id_num COMMA\n");}
		      | id_num {printf("arguments_list_actual-->id_num\n");}
		      |
                      ; 
id_num           : ID {printf("id_num --> ID\n");}
                 | NUMBER {printf("id_num --> NUMBER\n");}
                 |
                 ;  



return_statement : RETURN id_num SEMI{printf("return --> RETURN id_num SEMI\n");}

code_block       : code_block code_block {printf("code_block-->double code_block\n");}
                 | declar_statement {printf("code_block-->declar_statement\n");}
		 | assign_statement {printf("code_block-->asssign_statement\n");}	      
                 | call_func {printf("code_block-->call_func\n");}
		 | if_statement {printf("code_block-->if_statement");}
		 | else_if_statement {printf("code_block-->else_if_statement\n");}
                 | else_statement {printf("code_block-->else_statement\n");}
		 | while_statement {printf("code_block-->while_statement\n");}
		 | for_statement {printf("code_block-->for_statement\n");}
		 |
 		 ;

declar_statement : TYPE ID SEMI {printf("declar_statement --> TYPE ID SEMI\n");}
		 |
		 ; 

type_id : TYPE ID {printf("type_id --> TYPE ID\n");} 
	| ID {printf("type_id --> ID\n");}
	|
	;

number_result : id_num {printf("number_result-->id_num\n");}
	      | id_num id_num CALCULOP {printf("number-->id_num CALCULOP id_num\n");}
	      |number_result number_result CALCULOP {printf("number_result-->number_result number_result CALCULOP\n");}
	      ;

equal_semi : EQUALOP {printf("equal_semi --> EQUALOP\n");}
	   | EQUALOP SEMI {printf("equal_semi --> EQUALOP SEMI\n");}
           |
	   ;	      

assign_statement : type_id number_result equal_semi {printf("assign_statement -->type_id number_result EQUALOP SEMI  \n");}
		  | ID AUTOCHANGEOP SEMI {printf("assign_statement --> ID AUTOCHANGEOP SEMI\n");}
                  | ID AUTOCHANGEOP {printf("assign_statement --> ID AUTOCHANGEOP");}
		  |
		  ;

call_func : ID LB arguments_list_actual RB SEMI {printf("func-->ID LB arguments_list_actual RB SEMI\n");}
     |
     ;			


logic_expression : id_num id_num COMPAREOP {printf("loginc_expression --> id_num COMPAREOP id_num\n");}
		 |
		 ;

if_statement : IF LB logic_expression RB LBBB code_block RBBB {printf("if_statement-->IF LB logic_expression RB LBBB code_block RBBB\n");}
              |
              ;

else_if_statement : ELSE IF LB logic_expression RB LBBB code_block RBBB {printf("else_if_statement --> ELSE IF LB logic_expression RB LBBB code_block RBBB\n");}
		  |
		  ; 

else_statement : ELSE LBBB code_block RBBB {printf("else_statement-->ELSE LBBB code_block RBBB\n");}
               |
               ;
while_statement : WHILE LB logic_expression RB LBBB code_block RBBB {printf("while_statement--> WHILE LB id_num COMPAREOP id_num RB LBBB code_block RBBB\n");}
		|
		;
for_statement : FOR LB assign_statement logic_expression SEMI assign_statement RB LBBB code_block RBBB {printf("for_statement-->FOR LB assign_statement SEMI logic_expression SEMI assign_statement RB LBBB code_block RBBB");}
	      |
    	      ;

%%
int main(int argc, char* argv[]){
extern FILE* yyin;    
    yyin = fopen("input","r");
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
