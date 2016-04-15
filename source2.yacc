
%{ 
	#include <stdio.h> 
	#include <stdlib.h>
	#include <string.h>
	
	
%}
%start Prg
%token t_MAIN t_PRINTF t_RETURN t_IF t_ELSE t_WHILE t_CST t_INT t_ID t_STRING t_PO t_PF t_AO t_AF t_ESP t_TAB t_VIR t_PVIR t_RLI t_NB t_EQUAL
 
%right t_EQUAL 
%left t_ADD t_SUB
%left t_MUL t_DIV  

%type <value> Dec
%type <value> t_NB
%type <name> t_ID
%union{int value; char name[20]; }

%%
Prg: Fct Prg {printf("un programme part1\n");}
     | Fct {printf("un programme part2\n");};

Fct: t_INT t_MAIN t_PO Arg t_PF Body {printf("le main\n");};
Fct: t_INT t_ID t_PO Arg t_PF Body {printf("une fonction %s \n",$2);};
Body:t_AO LDecs  LIns  Return t_AF {printf("un corps\n");};  

Return: t_RETURN {printf("coucou\n");}Exp {printf("coucou\n");}t_PVIR {printf("return part3 \n");}
	  | ; 	   

Arg: {printf("Des parametres Part1\n");}
   | t_INT t_ID ArgS {printf("Des parametres Part3\n");};
ArgS: t_VIR t_INT t_ID ArgS {printf("Des parametres Part2\n");};
ArgS: {};

LDecs: ;
LDecs: t_INT SDecs LDecs {printf("Une liste de déclarations\n");};
SDecs: Dec t_VIR SDecs {printf("suite de déclarations\n");}
	 | Dec t_PVIR{printf("une declaration\n");};
Dec: t_ID t_EQUAL Exp {printf("une déclaration de type T_ID T_EQUAL Exp %s =  \n",$1);}
     |t_ID {printf("une declaration de type T_ID %s \n",$1);}
      ;

LIns: Ins LIns{printf("Liste d'instructions part1\n");};
LIns: {printf("Liste d'instructions part2\n");};

Ins: t_PRINTF t_PO Exp  t_PF t_PVIR {printf("instruction de type t_PRINTF t_STRING ect\n");};
Ins: t_ID t_EQUAL Exp t_PVIR {printf("instruction de type Exp\n");};
Ins: t_IF t_PO Exp t_PF Body EndOrElse {printf("instruction de type IF\n");};
Ins: t_WHILE t_PO Exp t_PF Body {printf("instruction de type WHILE\n");};
EndOrElse: t_ELSE Body{printf("instruction de type ELSE");}
	|{printf("end of an if");};

Exp: t_PO Exp t_PF {printf("expression (E)\n");}
   | Exp t_ADD Exp {printf("expression E+E\n");}
   | Exp t_MUL Exp {printf("expression E*E\n");}
   | Exp t_SUB Exp {printf("expression E-E\n");}
   | Exp t_DIV Exp {printf("expression E/E\n");}
   | t_NB {printf("expression t_NB %d\n", $1);}
   | t_ID {printf("expression t_STRING\n");}
   | Exp t_EQUAL t_EQUAL Exp {printf(" expression E == E\n");}; 
%%

	main(){
		return yyparse();
	}
    yyerror(char* s){
    	fprintf(stderr,"%s\n",s);
    }

