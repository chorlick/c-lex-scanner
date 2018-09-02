#define YYDEBUG 1

#include <cstdlib>
#include <cstdio>
#include <vector>
#include <string>
#include <iostream>
#include <stack>
#include <list>

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
};

stack<int> blocks;
vector<symbol *> symbols;

void yyerror(const char *s) {
        printf("Parse error!  Message: %s\n", s);
        exit(-1);
}

void newSymbol(int type, string name) {
        symbol * t = new symbol();
        t->name = name;
        t->type = type;
        symbols.push_back(t);
}

void deleteSymbolTable() {
        for (std::vector<symbol *>::iterator it = symbols.begin(); it != symbols.end(); ++it) {
                symbol * t = *it;
                delete t;
        }
}

void findFunctions() {
        list<symbol *> functions;
        vector<symbol *>::iterator it = symbols.begin();
        list<symbol *>::iterator pit;

        for (it; it != symbols.end(); ++it) {
                symbol * t = *it;
                if(t->type == IDENTIFIER) {
                        functions.push_back(t);
                }
        }

        pit = functions.begin();
        for(pit; pit != functions.end(); ++pit) {
                symbol * t = *pit;

                cout << "Possible function " << t->name << endl;

        }

}


void findNewSkillProcedures() {

}


void processSymbolTable() {
        findFunctions();
}


void printSymbolTable() {
        for (std::vector<symbol *>::iterator it = symbols.begin(); it != symbols.end(); ++it) {
                symbol * t = *it;
                cout << "Name : " << t->name << " " << "Type : " << t->type << endl;
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
        while(yylex()) {
                switch(yylval) {
                case VOID:
                        newSymbol(VOID, yytext);
                        break;
                case CHAR:
                        newSymbol(CHAR, yytext);
                        break;
                case IF:
                        newSymbol(IF, yytext);
                        break;
                case INT:
                        newSymbol(INT, yytext);
                        break;
                case IDENTIFIER:
                        newSymbol(IDENTIFIER, yytext);
                        break;

                case '{':
                        newSymbol('{', yytext);
                        break;
                case '}':
                        newSymbol('}', yytext);
                        break;
                case '(':
                        newSymbol('(', yytext);
                        break;
                case ')':
                        newSymbol(')', yytext);
                        break;
                case NE_OP:
                        newSymbol(NE_OP, yytext);
                        break;
                case EQ_OP:
                        newSymbol(EQ_OP, yytext);
                        break;
                case '=':
                        newSymbol('=', yytext);
                        break;
                case I_CONSTANT:
                        newSymbol(I_CONSTANT, yytext);
                        break;
                default:
                        cout << yytext<< " " << yylval<<  endl;
                        break;
                }

        }
        cout << "Parsing Complete" << endl;
        printSymbolTable();
        processSymbolTable();
        deleteSymbolTable();
        return 0;
}
