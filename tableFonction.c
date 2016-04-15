#include"tablefonc.h"


void initTF( tabF** tF){
	*tF = malloc(sizeof(tabF));
	*tF->index = 0;
}

void delTab(tabF * tF){
	free(tF); 
}

void addFonc(tabF *tableauFonction, char *n, char in, int d){
	strcpy(tableauFonction->tab[tableauFonction->index].name , n);
}

int getAdrFonc(tabF *tableauFonction, char *n){}

void delFonc(tabF *tableau){}

void printTabFon(tabF *tF){}

int getSize(tabF *tF){}
