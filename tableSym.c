#include "tableSym.h"



void initTS( tabS** ts){
	*ts=malloc(sizeof(tabS));
	(*ts)->index =0; 
}

void delTabS(tabS* TS){
 free(TS);
}

void addVar(tabS *tableauSymbole, char *n, char in, int d){
	strcpy(tableauSymbole->tab[tableauSymbole->index].name , n);
	tableauSymbole->tab[tableauSymbole->index].init =in; 
	tableauSymbole->tab[tableauSymbole->index].depth = d;
	tableauSymbole->index++; 
}

int getAdr(tabS *tableauSymbole, char *n){
	int i = 0;
	int j = tableauSymbole->index+1;
	int res = -1; 
	for( i=0;i<j; i++){
		if (strcmp(tableauSymbole->tab[i].name, n) == 0)
			res=i; 
	}
	return res; 
}

void delVar(tabS *tableau){
	tableau->index--;
}



void printTab(tabS *ts){
	int i;
	for(i=0;i < ts->index; i++){
	printf("| name :%s",ts->tab[i].name);
	printf("| init :%d",ts->tab[i].init);
	printf("| depth :%d | \n",ts->tab[i].depth);
	} 
}


int getSize(tabS *ts) {
	return ts->index;
}

/*
int main (void){
	tabS *ts; 
	initTS(&ts); 
	int i=0;
	for(i=0;i<5;i++){
		addVar(ts,"toto",'a',i);
	}	
	printTab(ts); 
	delVar(ts);
	addVar(ts,"truc",'t',12);
	printTab(ts); 
	delAdr(ts, "truc");
return 0;
}
*/
