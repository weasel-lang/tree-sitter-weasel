ifeq ($(OS),Windows_NT)
$(error Windows is not supported)
endif

LANGUAGE_NAME := tree-sitter-weasel

SRC_DIR := src
TS ?= tree-sitter

override CFLAGS += -I$(SRC_DIR) -std=c11 -fPIC

PARSER := $(SRC_DIR)/parser.c
EXTRAS := $(filter-out $(PARSER),$(wildcard $(SRC_DIR)/*.c))
OBJS := $(patsubst %.c,%.o,$(PARSER) $(EXTRAS))

ifeq ($(shell uname),Darwin)
	SOEXT = dylib
	LINKSHARED = -dynamiclib
else
	SOEXT = so
	LINKSHARED = -shared
endif

all: lib$(LANGUAGE_NAME).a lib$(LANGUAGE_NAME).$(SOEXT)

lib$(LANGUAGE_NAME).a: $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

lib$(LANGUAGE_NAME).$(SOEXT): $(OBJS)
	$(CC) $(LDFLAGS) $(LINKSHARED) $^ $(LDLIBS) -o $@

$(PARSER): $(SRC_DIR)/grammar.json
	$(TS) generate $^

clean:
	$(RM) $(OBJS) lib$(LANGUAGE_NAME).a lib$(LANGUAGE_NAME).$(SOEXT)

test:
	$(TS) test

.PHONY: all clean test
