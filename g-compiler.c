#include <stdlib.h>
#include <stdio.h>
#include <gc/gc.h>

#include "lexer.h"
#include "parser.h"
#include "memory.h"

void *ParseAlloc(void *(*allocProc)(size_t));
void Parse(void *, int, const char *);
void ParseFree(void *, void (*freeProc)(void *));

const char *input =
    "%"
    "M48"
    "METRIC,000.000"
    "T01C0.40"
    "T02C0.80"
    "T03C0.81"
    "T04C0.91"
    "T05C1.20"
    "T10C0.50"
    "T11C1.00"
    "T12C0.76"
    "T13C1.50"
    "T14C3.00"
    "T15C0.60"
    "T16C0.90"
    "T17C1.02"
    "T18C1.30"
    "T19C1.52"
    "%"
    "T01"
    "X125250Y087473"
    "X121440Y090013"
    "X087150Y095093"
    "X222954Y069384"
    "X225240Y055668"
    "X233114Y054638"
    "X235019Y055414"
    "X239718Y058716"
    "X226954Y121384"
    "X229240Y107668"
    "X237114Y106639"
    "X239019Y107414"
    "X243718Y110716"
    "M30";

int main(int argc, char **argv)
{
    GC_init();

    void *parser = ParseAlloc(GC_malloc);

    yyscan_t lexer;
    yylex_init(&lexer);

    YY_BUFFER_STATE buffer_state = yy_scan_string(input, lexer);

    int token;
    while ((token = yylex(lexer))) {
        if (-1 == token) {
            break;
        }

        char *text = gc_strdup(yyget_text(lexer));
        Parse(parser, token, text);
    }

    Parse(parser, 0, NULL);

    yy_delete_buffer(buffer_state, lexer);

    yylex_destroy(lexer);

    ParseFree(parser, GC_free);

    return EXIT_SUCCESS;
}
