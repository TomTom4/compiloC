%{ 
	#include <stdio.h> 
	#include <stdlib.h>
	#include "y.tab.h"

	//#define PRT_DBG(...)do { printf(__VA_ARGS__); } while (0)
	#define PRT_DBG(...) ;
%}

%%

"main"		{ PRT_DBG(">%s<\n", yytext); return t_MAIN; }
"printf"	{ PRT_DBG(">%s<\n", yytext); return t_PRINTF; }
"return"	{ PRT_DBG(">%s<\n", yytext); return t_RETURN; }
"if"		{ PRT_DBG(">%s<\n", yytext); return t_IF; }
"else"		{ PRT_DBG(">%s<\n", yytext); return t_ELSE; }
"while"		{ PRT_DBG(">%s<\n", yytext); return t_WHILE; }

"int"		{ PRT_DBG(">%s<\n", yytext); return t_INT; }
"const"		{ PRT_DBG(">%s<\n", yytext); return t_CST; }
[a-z]+([a-z]*|[0-9]*|_)([a-z]*[0-9]*)		{ strcpy(yylval.name,yytext); PRT_DBG(">%s<\n", yytext); return t_ID;}

\".*\"		{ PRT_DBG(">%s<\n", yytext); return t_STRING; }
"{"			{ PRT_DBG(">%s<\n", yytext); return t_AO; }
"}"			{ PRT_DBG(">%s<\n", yytext); return t_AF; }
"("			{ PRT_DBG(">%s<\n", yytext); return t_PO; }
")"			{ PRT_DBG(">%s<\n", yytext); return t_PF; }
;			{ PRT_DBG(">%s<\n", yytext); return t_PVIR; }
,			{ PRT_DBG(">%s<\n", yytext); return t_VIR;}
[ \t\n]+	;


([0-9]+\.?[0-9]*|[0-9]*e[0-9])				{ yylval.value = atoi(yytext); PRT_DBG(">%s<\n", yytext); return t_NB;}
"+"			{ PRT_DBG(">%s<\n", yytext); return t_ADD; }
"-"			{ PRT_DBG(">%s<\n", yytext); return t_SUB; }
"*"			{ PRT_DBG(">%s<\n", yytext); return t_MUL; }
"/"			{ PRT_DBG(">%s<\n", yytext); return t_DIV; }
"="			{ PRT_DBG(">%s<\n", yytext); return t_EQUAL; }
"=="		{ PRT_DBG(">%s<\n", yytext); return t_EQU; }
">"			{ PRT_DBG(">%s<\n", yytext); return t_SUP; }
"<"			{ PRT_DBG(">%s<\n", yytext); return t_INF; }
"&"			{ PRT_DBG(">%s<\n", yytext); return t_ESP; }
