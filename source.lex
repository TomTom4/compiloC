%{ 
	#include <stdio.h> 
	#include <stdlib.h>
	#include "y.tab.h"
%}
%%

"main" printf("j'ai trouvé le main!\n");
"printf" printf("j'ai trouvé un printf \n"); 
"return" printf("j'ai trouvé un return \n"); 
"if" printf("j'ai trouvé un if");
"else" printf("j'ai trouvé un else");
"while" printf("j'ai trouvé un while");
int printf("j'ai trouvé le type INT !\n");
const printf("j'ai trouvé le type const !\n");
[a-z]+([a-z]*|[0-9]*|_)([a-z]*[0-9]*) printf("j'ai trouvé un identifiant!\n");

\".*\" printf("j'ai trouvé une String !\n");
"{" printf("j'ai trouvé une accolade ouvrante !\n"); 
"}" printf("j'ai trouvé une accolade fermante !\n");
"(" printf("j'ai trouvé une parenthèse ouvrante!\n");
")" printf("j'ai trouvé une parenthèse fermante!\n");
" " printf("j'ai trouvé un espace!\n");
"	" printf("j'ai trouvé une tabulation!\n");
";"  printf("j'ai trouvé un point virgule\n");
"," printf("j'ai trouvé une virgule!\n");
"\n" printf(" j'ai trouvé un retour à la ligne! \n"); 


([0-9]+,?[0-9]*|[0-9]*e[0-9]) printf("j'ai trouvé un nombre!\n");
"+"  printf("j'ai trouvé un +!\n");
"-" printf("j'ai trouvé un -!\n");
"*" printf("j'ai trouvé un *!\n");
"/" printf("j'ai trouvé un /!\n");
"=" printf("j'ai trouvé un =!\n");




