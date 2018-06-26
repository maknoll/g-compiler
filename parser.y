%include {
    #include <assert.h>
    #include <stdio.h>
}

%syntax_error {
    fprintf(stderr, "%s", "Syntax Error!\n");
}

%start_symbol start

start ::= header statement_list.
start ::= error. {
    fprintf(stderr, "%s", "Parser Error!\n");
}

header ::= HEADERSTART statement_list PERCENT. {
    fprintf(stderr, "%s", "Header with M48 and %\n");
}
header ::= HEADERSTART statement_list HEADEREND. {
    fprintf(stderr, "%s", "Header with M48 and M95\n");
}
header ::= PERCENT statement_list HEADEREND. {
    fprintf(stderr, "%s", "Header with % and M95\n");
}
header ::= PERCENT statement_list PERCENT. {
    fprintf(stderr, "%s", "Header with % and %\n");
}

statement_list ::= statement_list statement.
statement_list ::= statement.

statement ::= option.
statement ::= command.

option ::= OPTION COMMA OPTION.
option ::= OPTION COMMA NUMBER.
option ::= OPTION.

command ::= COMMAND NUMBER parameter_list.
command ::= COMMAND NUMBER.

parameter_list ::= parameter_list parameter.
parameter_list ::= parameter.

parameter ::= PARAMETER NUMBER.
