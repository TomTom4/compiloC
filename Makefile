YSOURCE = source3.yacc
FSOURCE = source2.lex
OUTPUT = appa

all: $(OUTPUT)

tableSym.o: tableSym.c tableSym.h
	gcc -Wall -c tableSym.c

$(OUTPUT): tableSym.o y.tab.o lex.yy.o
	gcc -g y.tab.o lex.yy.o tableSym.o -ll -o $(OUTPUT)

y.tab.o: $(YSOURCE)
	yacc -d -v $(YSOURCE)
	gcc -Wall -c y.tab.c

lex.yy.o: $(FSOURCE)
	flex $(FSOURCE)
	gcc -Wall -c lex.yy.c
