#include <stdlib.h>
#include <gc/gc.h>

#include "parser.h"

void *ParseAlloc(void *(*allocProc)(size_t));
void ParseFree(void *, void (*freeProc)(void *));

int main(int argc, char **argv)
{
    GC_init();

    void *parser = ParseAlloc(GC_malloc);

    ParseFree(parser, GC_free);

    return EXIT_SUCCESS;
}
