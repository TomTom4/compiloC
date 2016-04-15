#ifndef TABLESYM_H
#define TABLESYM_H
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

typedef struct {
	char name[20];
	char init; 
	int depth; 
}lineT;


typedef struct {
	lineT tab[255];
	int index; 
} tabF;

void initTS( tabS** ts);
void delTabS(tabS* TS);
void addVar(tabS *tableauSymbole, char *n, char in, int d);
int getAdr(tabS *tableauSymbole, char *n);
void delVar(tabS *tableau);
void printTab(tabS *ts);
int getSize(tabS *ts);

#endif
