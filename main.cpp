#define YYDEBUG 1

#include <cstdlib>
#include <cstdio>
#include <vector>
#include <string>
#include <iostream>

#include "skill.tab.h"

using namespace std;
// Declare stuff from Flex that Bison needs to know about:
void yyerror(const char *s);
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern FILE *yyin;
extern FILE *yyout;
extern char *yytext;

extern int yylval;

using namespace std;



struct symbol {
        string type;
        string name;
        vector<symbol> arguments;
};

struct scope {
        vector<symbol *> symbols;
};

vector<scope *> scopes;
vector<int> symbol_stack;

void yyerror(const char *s) {
        printf("Parse error!  Message: %s\n", s);
        exit(-1);
}

void newScope() {
        scopes.push_back(new scope);
}

void newSymbol() {

}

void deleteSymbolTable() {

}


void printSymbols(symbol * s) {

}

void printSymbolTable() {
        int i = 0;
        for (std::vector<scope *>::iterator it = scopes.begin(); it != scopes.end(); ++it) {
                scope * t = *it;
                cout << "Scope " << i++ << endl;
        }
}

int main(int argc, char* argv[]) {
        // Open a file handle to a particular file:
        FILE *myfile = fopen(argv[1], "r");
        if (!myfile) {
                printf("File not found %s\n", argv[1]);
                return -1;
        }

        cout << "Parsing " << argv[1] << endl;
        // Set Flex to read from it instead of defaulting to STDIN:
        yyin = myfile;
        yyout = fopen("/dev/null", "w");
        // Parse through the input:
        newScope();
        while(yylex()) {
                switch(yylval) {
                case VOID:
                        break;
                case IDENTIFIER:
                        break;

                case '(':

                        break;

                case ')':
                        break;
                }



        }


        cout << "Parsing Complete" << endl;
        printSymbolTable();
        return 0;
}
