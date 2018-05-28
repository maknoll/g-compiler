%include {
    #include <assert.h>
}

start ::= statement_list.

statement_list ::= statement_list statement.
statement_list ::= statement.

statement ::= PERCENT.
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
