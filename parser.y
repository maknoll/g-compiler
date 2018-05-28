%include {
    #include <assert.h>
}

start ::= rule.

rule ::= rule TOKEN.
rule ::= TOKEN.
