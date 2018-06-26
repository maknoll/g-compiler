%{
#include "parser.h"
%}

%option reentrant
%option noyywrap
%option noinput
%option nounput

%%

"%"                         return PERCENT;
"M48"                       return HEADERSTART;
"M95"                       return HEADEREND;
","                         return COMMA;

[a-zA-Z][a-zA-Z]+           return OPTION;
[mgtMGT]                    return COMMAND;
[xyzchfsXYZCHFS]            return PARAMETER;
[0-9]+(\.[0-9]+)?           return NUMBER;

[ \t\n]+                    ;

%%
