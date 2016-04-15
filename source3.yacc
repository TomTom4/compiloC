
%{ 
	#include <stdio.h> 
	#include <stdlib.h>
	#include <string.h>
	#include "tableSym.h"

	#define PRT_DBG(...)do { printf(__VA_ARGS__); } while (0) 
	// resolution
	tabS *ts; 
	int d = 0;
	int idx_tmp = 0;
	int tabIns[512][4];
	int index_tabIns = 0;
%}
%start Prg
%token t_MAIN t_PRINTF t_RETURN t_CST t_INT t_ID t_STRING t_PO t_PF t_AO t_AF t_ESP t_TAB t_VIR t_PVIR t_RLI t_NB  t_IF t_ELSE t_WHILE t_EQU t_SUP t_INF t_ESP

%token t_EQUAL 
%right t_EQUAL
%left t_EQU t_SUP t_INF
%left t_ADD t_SUB
%left t_MUL t_DIV
%left t_ESP

%type <value> t_NB
%type <name> t_ID
%type <value> Exp
%type <value> t_IF
%type <value> t_ELSE
%type <value> EndOrElse
%type <value> t_WHILE

%union{int value; char name[20]; }

%%

Prg: Fct Prg {PRT_DBG("un programme part1\n");}
     | Fct {PRT_DBG("un programme part2\n");};

Fct: t_INT t_MAIN t_PO Arg t_PF Body {PRT_DBG("le main\n");};
Fct: t_INT t_ID t_PO Arg t_PF Body 
		{
			PRT_DBG("une fonction %s \n",$2);
		};
Body:t_AO LDecs  LIns  Return t_AF {PRT_DBG("un corps\n");};  

Return: t_RETURN Exp t_PVIR {PRT_DBG("return part3 \n");}
	  | ; 
	   

Arg: {PRT_DBG("Des parametres Part1\n");}
   | t_INT t_ID ArgS {PRT_DBG("Des parametres Part3\n");};
ArgS: t_VIR t_INT t_ID ArgS {PRT_DBG("Des parametres Part2\n");};
ArgS: {};

LDecs: ;
LDecs: t_INT SDecs LDecs {PRT_DBG("Une liste de déclarations\n");};
SDecs: Dec t_VIR SDecs {PRT_DBG("suite de déclarations\n");}; 
SDecs: Dec t_PVIR{PRT_DBG("une declaration\n");};
Dec: t_ID
	   {
	     PRT_DBG("une declaration de type T_ID %s \n",$1);
	     addVar(ts, $1, 0, d);
	   }
   | t_ID t_EQUAL
       {
         PRT_DBG("nb symboles: %d\n", getSize(ts));
         idx_tmp=getSize(ts);
       }
     Exp
       {
         PRT_DBG("une déclaration de type T_ID T_EQUAL Exp %s \n",$1);
         addVar(ts, $1, 1, d);
         PRT_DBG("COP %d %d\n", getAdr(ts, $1), $4);
         idx_tmp--;
         }
    | t_MUL t_ID
        {
          PRT_DBG("une déclaration de type pointer %s \n",$2);
          addVar(ts, $2, 0, d);
          
        }
    | t_MUL t_ID t_EQUAL
             {
         		PRT_DBG("nb symboles : %d \n", getSize(ts));
         		idx_tmp=getSize(ts);
       		}
     Exp	
     		{
     			PRT_DBG("une déclaration de type pointer =  Exp %s \n",$2);
         		addVar(ts, $2, 1, d);
         		PRT_DBG("PCOPA %d %d\n", getAdr(ts, $2), $5);
         		idx_tmp--;
     		};

Params: Param ParamsS
	  |;
ParamsS: t_VIR Param ParamsS
	  |;
Param : t_MUL t_ID
	  | Exp ;        

LIns: Ins LIns{PRT_DBG("Liste d'instructions part1\n");};
LIns: {PRT_DBG("Liste d'instructions part2\n");};

Ins: t_PRINTF t_PO Exp  t_PF t_PVIR {
									PRT_DBG("instruction de type t_PRINTF t_exp ect\n");
									tabIns[index_tabIns][0]= 12;
   									tabIns[index_tabIns][1]= $3;
   									tabIns[index_tabIns][2]= -1;
   									tabIns[index_tabIns][3]= -1;
   									index_tabIns++;
									};

	 
Ins: t_ID 
		{
			PRT_DBG("nb symboles: %d\n", getSize(ts));
			idx_tmp=getSize(ts);
		} 
	  t_EQUAL Exp t_PVIR 
	    {
	    PRT_DBG("COP %d %d\n",getAdr(ts, $1),$4);
	    idx_tmp--;
	    };
	    
Ins: t_MUL t_ID 
				{
					PRT_DBG("nb symboles: %d\n", getSize(ts));
					idx_tmp=getSize(ts);
				} 
	t_EQUAL Exp t_PVIR 
				{
					PRT_DBG("PCOPA %d %d\n",getAdr(ts, $2),$5);
					idx_tmp--;
				};

				
Ins: t_IF t_PO Exp t_PF
		{
   					tabIns[index_tabIns][0]= 8;
   					tabIns[index_tabIns][1]= $3;
   					tabIns[index_tabIns][2]= -1;
   					tabIns[index_tabIns][3]= -1;
					$1 = index_tabIns;	 /* $1 contient l'adresse du jmf */
   					index_tabIns++;
   		}
	 Body
	 	{
	 				tabIns[$1][2] = index_tabIns;
	 	}
	 EndOrElse
	 	{
	 				tabIns[$1][2] += $8;
	 				PRT_DBG("instruction de type IF\n");
	 	};
	 
Ins: t_WHILE t_PO Exp t_PF{
							tabIns[index_tabIns][0]= 8;
   							tabIns[index_tabIns][1]= $3;
   							tabIns[index_tabIns][2]= -1;
   							tabIns[index_tabIns][3]= -1;
							$1 = index_tabIns-1;	 /* $1 contient l'adresse du jmf */
   							index_tabIns++;/*JMF*/
   						 } 
   					Body{
   						
   							/*JMP*/
   						tabIns[index_tabIns][0]= 7;
   						tabIns[index_tabIns][1]= $1;
   						tabIns[index_tabIns][2]= -1;
   						tabIns[index_tabIns][3]= -1;
   						index_tabIns++;
   						tabIns[$1+1][2] = index_tabIns;
   						} 
   						{
   						PRT_DBG("instruction de type WHILE\n");
   						};
/*
Ins: t_ID t_EQUAL t_ID t_PO Params t_PF t_PVIR
	 {
	 	PRT_DBG("une fonction %s en instruction \n ", $3);
	 };
	*/ 
EndOrElse: t_ELSE
				{
   					tabIns[index_tabIns][0]= 7;
   					tabIns[index_tabIns][1]= -1;
   					tabIns[index_tabIns][2]= -1;
   					tabIns[index_tabIns][3]= -1;
					$1 = index_tabIns;	 /* $1 contient l'adresse du jmp */
   					index_tabIns++;
				}
			Body
				{
					tabIns[$1][1] = index_tabIns;
					PRT_DBG("instruction de type ELSE");
					$$ = 1;
				}
		 |		{ PRT_DBG("end of an if"); $$ = 0; };

Exp: t_PO Exp t_PF {PRT_DBG("expression (E)\n");$$=$2;}
   | Exp t_ADD Exp {
   					PRT_DBG("expression E+E\n");
   					$$=$1;
   					PRT_DBG("ADD %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 1;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   					
   | Exp t_MUL Exp {
   					PRT_DBG("expression E*E\n");
   					$$=$1;
   					PRT_DBG("MUL %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 2;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   					
   | Exp t_EQU Exp {
   					PRT_DBG("expression E==E\n");
   					$$=$1;
   					PRT_DBG("EQU %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 11;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   | Exp t_SUB Exp {
   					PRT_DBG("expression E-E\n");
   					$$=$1;
   					PRT_DBG("SUB %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 3;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   | Exp t_DIV Exp {
   					PRT_DBG("expression E/E\n");
   					$$=$1;
   					PRT_DBG("DIV %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 4;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   | Exp t_SUP Exp {
   					PRT_DBG("expression E>E\n");
   					$$=$1;
   					PRT_DBG("SUP %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 10;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   | Exp t_INF Exp {
   					PRT_DBG("expression E<E\n");
   					$$=$1;
   					PRT_DBG("INF %d %d %d\n", $1, $1, $3);
   					idx_tmp--;
   					tabIns[index_tabIns][0]= 9;
   					tabIns[index_tabIns][1]= $1;
   					tabIns[index_tabIns][2]= $1;
   					tabIns[index_tabIns][3]= $3;
   					index_tabIns++;
   					}
   | t_NB  {
   			PRT_DBG("AFC %d %d\n", idx_tmp, $1);
   			$$=idx_tmp;
   			idx_tmp++;
   			tabIns[index_tabIns][0]= 6;
   			tabIns[index_tabIns][1]= $$;
   			tabIns[index_tabIns][2]= $1;
   			tabIns[index_tabIns][3]= -1;
   			index_tabIns++;
   			}
   | t_ID {
   			PRT_DBG("COP %d %d\n", idx_tmp, getAdr(ts, $1));
   			$$=idx_tmp;
   			idx_tmp++;
   			tabIns[index_tabIns][0]= 5;
   			tabIns[index_tabIns][1]= $$;
   			tabIns[index_tabIns][2]= getAdr(ts, $1);
   			tabIns[index_tabIns][3]= -1;
   			index_tabIns++;
   			}
   | t_ESP t_ID {
   			PRT_DBG("PCOPB %d %d\n", idx_tmp, getAdr(ts, $2));
   			$$=idx_tmp;
   			idx_tmp++;
   			tabIns[index_tabIns][0]= 5;
   			tabIns[index_tabIns][1]= $$;
   			tabIns[index_tabIns][2]= getAdr(ts, $2);
   			tabIns[index_tabIns][3]= -1;
   			index_tabIns++;
   			}
   	|  t_ID t_PO Params t_PF {} ;
   			
%%

	main(){
		initTS(&ts);
		yyparse();
		printTab(ts);
		printf("*********tab_INS*************\n");
		int i = 0, j =0;
		for (i=0;i <(index_tabIns+1 );i++){
			printf("line:%d ",i);
			for(j=0;j < 4; j++)
				printf("|%d",tabIns[i][j]);
			printf("\n");
		}
	}
    yyerror(char* s){
    	fprintf(stderr,"%s\n",s);
    }
   

