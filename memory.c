#include <string.h>
#include <gc/gc.h>

#include "memory.h"

char *gc_strdup(const char *source)
{
    if (!source) {
        return NULL;
    }

    size_t length = strlen(source);

    char *result = GC_malloc((length + 1) * sizeof(char));
    if (!result) {
        return NULL;
    }

    (void)memcpy(result, source, length + 1);

    return result;
}
