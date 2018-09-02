
lex :
	- rm lex.yy.c skill.tah.h y.tab.c y.tab.h skill.tab.c
	bison -d skill.y
	flex skill.l
	g++ -std=c++11 skill.tab.c lex.yy.c main.cpp -o skillp -ll -ly
	./skillp test.c
