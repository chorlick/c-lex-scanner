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
        int type;
        string name;
        vector<symbol> arguments;
};

vector<symbol *> symbol_table;

void yyerror(const char *s) {
        printf("Parse error!  Message: %s\n", s);
        // might as well halt now:
        exit(-1);
}

void newSymbol() {
  symbol * t = new symbol;
  t->name = yytext;
  symbol_table.push_back(t);
}

void handleVoid() {
  newSymbol();
}

void deleteSymbolTable() {
  for (std::vector<symbol *>::iterator it = symbol_table.begin() ; it != symbol_table.end(); ++it) {
    delete *it;
  }
}

void printSymbolTable() {
  for (std::vector<symbol *>::iterator it = symbol_table.begin() ; it != symbol_table.end(); ++it) {
    cout << "Name " << *it->name;
  }
}

int main(int argc, char* argv[]) {
        // Open a file handle to a particular file:
        FILE *myfile = fopen(argv[1], "r");
        // Make sure it is valid:

        if (!myfile) {
                printf("File not found %s\n", argv[1]);
                return -1;
        }

        cout << "Parsing " << argv[1] << endl;
        // Set Flex to read from it instead of defaulting to STDIN:
        yyin = myfile;
        yyout = fopen("/dev/null", "w");
        // Parse through the input:
        while(yylex()) {
                switch(yylval) {
                case VOID:

                        handleVoid();
                        break;
                }

                case IDENTIFIER :
                  newSymbol();
                break;
        }

        cout << "Parsing Complete" << endl;

        return 0;
}
