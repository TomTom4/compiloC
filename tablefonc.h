#ifndef TABLEFON_H
#define TABLEFON_H
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

void initTF( tabF** tF);
void delTabF(tabF* TF);
void addVar(tabF *tableauFymbole, char *n, char in, int d);
int getAdr(tabF *tableauFymbole, char *n);
void delVar(tabF *tableau);
void printTab(tabF *tF);
int getSize(tabF *tF);

#endif
