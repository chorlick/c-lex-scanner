%e  1019
%p  2807
%n  371
%k  284
%a  1213
%o  1117

O   [0-7]
D   [0-9]
NZ  [1-9]
L   [a-zA-Z_]
A   [a-zA-Z_0-9]
H   [a-fA-F0-9]
HP  (0[xX])
E   ([Ee][+-]?{D}+)
P   ([Pp][+-]?{D}+)
FS  (f|F|l|L)
IS  (((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))
CP  (u|U|L)
SP  (u8|u|U|L)
ES  (\\(['"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))
WS  [ \t\v\n\f]

%{
#include <stdio.h>
#include "skill.tab.h"

extern void yyerror(const char *);  /* prints grammar violation message */



static void comment(void);
static int check_type(void);
%}

/* %option debug */
%option yymore
%option nodefault

%%
"/*"                                    { comment(); }
"//".*                                    { /* consume //-comment */ }

"auto"					{ yylval = AUTO; return(AUTO); }
"break"					{ yylval = BREAK; return(BREAK); }
"case"					{ yylval = CASE; return(CASE); }
"char"					{ yylval = CHAR; return(CHAR); }
"const"					{ yylval = CONST; return(CONST); }
"continue"				{ yylval = CONTINUE; return(CONTINUE); }
"default"				{ yylval = DEFAULT; return(DEFAULT); }
"do"					{ yylval = DO; return(DO); }
"double"				{ yylval = DOUBLE; return(DOUBLE); }
"else"					{ yylval = ELSE; return(ELSE); }
"enum"					{ yylval = ENUM; return(ENUM); }
"extern"				{ yylval = EXTERN; return(EXTERN); }
"float"					{ yylval = FLOAT; return(FLOAT); }
"for"					{ yylval = FOR; return(FOR); }
"goto"					{ yylval = GOTO; return(GOTO); }
"if"					{ yylval = IF; return(IF); }
"inline"				{yylval = INLINE; return(INLINE); }
"int"					{ yylval = INT; return(INT); }
"long"					{ yylval = LONG; return(LONG); }
"register"				{ yylval = REGISTER; return(REGISTER); }
"restrict"				{ yylval = RESTRICT; return(RESTRICT); }
"return"				{ yylval = RETURN; return(RETURN); }
"short"					{ yylval = SHORT; return(SHORT); }
"signed"				{ yylval = SIGNED; return(SIGNED); }
"sizeof"				{ yylval = SIZEOF; return(SIZEOF); }
"static"				{ yylval = STATIC; return(STATIC); }
"struct"				{ yylval = STRUCT; return(STRUCT); }
"switch"				{ yylval = SWITCH; return(SWITCH); }
"typedef"				{ yylval = TYPEDEF; return(TYPEDEF); }
"union"					{ yylval = UNION; return(UNION); }
"unsigned"				{ yylval = UNSIGNED; return(UNSIGNED); }
"void"					{ yylval = VOID; return(VOID); }
"volatile"				{ yylval = VOLATILE; return(VOLATILE); }
"while"					{ yylval = WHILE; return(WHILE); }
"_Alignas"                              { return ALIGNAS; }
"_Alignof"                              { return ALIGNOF; }
"_Atomic"                               { return ATOMIC; }
"_Bool"                                 { return BOOL; }
"_Complex"                              { return COMPLEX; }
"_Generic"                              { return GENERIC; }
"_Imaginary"                            { return IMAGINARY; }
"_Noreturn"                             { return NORETURN; }
"_Static_assert"                        { return STATIC_ASSERT; }
"_Thread_local"                         { return THREAD_LOCAL; }
"__func__"                              { return FUNC_NAME; }

{L}{A}*					{ yylval = IDENTIFIER; return check_type(); }

{HP}{H}+{IS}?				{ yylval = I_CONSTANT; return I_CONSTANT; }
{NZ}{D}*{IS}?				{yylval = I_CONSTANT; return I_CONSTANT; }
"0"{O}*{IS}?				{yylval = I_CONSTANT; return I_CONSTANT; }
{CP}?"'"([^'\\\n]|{ES})+"'"		{ yylval = I_CONSTANT; return I_CONSTANT; }

{D}+{E}{FS}?				{ yylval = F_CONSTANT; return F_CONSTANT; }
{D}*"."{D}+{E}?{FS}?			{ yylval = F_CONSTANT; return F_CONSTANT; }
{D}+"."{E}?{FS}?			{ yylval = F_CONSTANT; return F_CONSTANT; }
{HP}{H}+{P}{FS}?			{ return F_CONSTANT; }
{HP}{H}*"."{H}+{P}{FS}?			{ return F_CONSTANT; }
{HP}{H}+"."{P}{FS}?			{ return F_CONSTANT; }

({SP}?\"([^"\\\n]|{ES})*\"{WS}*)+	{ return STRING_LITERAL; }

"..."					{ return ELLIPSIS; }
">>="					{ return RIGHT_ASSIGN; }
"<<="					{ return LEFT_ASSIGN; }
"+="					{ return ADD_ASSIGN; }
"-="					{ return SUB_ASSIGN; }
"*="					{ return MUL_ASSIGN; }
"/="					{ return DIV_ASSIGN; }
"%="					{ return MOD_ASSIGN; }
"&="					{ return AND_ASSIGN; }
"^="					{ return XOR_ASSIGN; }
"|="					{ return OR_ASSIGN; }
">>"					{ return RIGHT_OP; }
"<<"					{ return LEFT_OP; }
"++"					{ return INC_OP; }
"--"					{ return DEC_OP; }
"->"					{ return PTR_OP; }
"&&"					{ return AND_OP; }
"||"					{ return OR_OP; }
"<="					{ return LE_OP; }
">="					{ return GE_OP; }
"=="					{ yylval = EQ_OP; return EQ_OP; }
"!="					{ yylval = NE_OP; return NE_OP; }
";"					{ return ';'; }
("{"|"<%")				{ yylval = '{'; return '{'; }
("}"|"%>")				{ yylval = '}'; return '}'; }
","					{ return ','; }
":"					{ return ':'; }
"="					{ yylval = '='; return '='; }
"("					{yylval = '('; return '('; }
")"					{yylval = ')'; return ')'; }
("["|"<:")				{ return '['; }
("]"|":>")				{ return ']'; }
"."					{ return '.'; }
"&"					{ return '&'; }
"!"					{ return '!'; }
"~"					{ return '~'; }
"-"					{ return '-'; }
"+"					{ yylval = atoi(yytext); return '+'; }
"*"					{ return '*'; }
"/"					{ return '/'; }
"%"					{ return '%'; }
"<"					{ return '<'; }
">"					{ return '>'; }
"^"					{ return '^'; }
"|"					{ return '|'; }
"?"					{ return '?'; }

{WS}+					{ /* whitespace separates tokens */ }
.					{ /* discard bad characters */ }

%%

int yywrap(void)        /* called at end of input */
{
    return 1;           /* terminate now */
}

static void comment(void)
{

}

static int check_type(void)
{
        return IDENTIFIER;
}
