BIN = g-compiler

CFLAGS = -g -Wall -Werror -std=c11
LDFLAGS =
LDLIBS = -lgc
YACC = lemon/lemon
YFLAGS = -q
LEX = flex
LFLAGS = --header-file=lexer.h

SOURCES = parser.c lexer.c g-compiler.c
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))

.PHONY: release lemon clean

$(BIN): $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

parser.c: lemon parser.y
	$(YACC) $(YFLAGS) parser.y

lexer.c: lexer.l parser.c
	$(LEX) $(LFLAGS) -o $@ $<

release: CFLAGS = -std=c11 -Os -march=native -flto -Wall -Wextra -Wpedantic -Wstrict-overflow -fno-strict-aliasing
release: $(BIN)

lemon:
	@make -C lemon

clean:
	rm -f $(BIN) $(OBJECTS) parser.c parser.h lexer.c lexer.h
