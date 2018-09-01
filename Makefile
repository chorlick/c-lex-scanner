
lex :
	- rm lex.yy.c skill.tab.c
	bison skill.y
	flex skill.l
	g++ skill.tab.c lex.yy.c -o skillp -ll -ly
