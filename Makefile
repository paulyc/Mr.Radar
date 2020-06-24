# fun with knives, time to party like it's 1978 and we work
# at Bell Labs despite AT&T's best efforts to make us all quit
she := \#
bang := !
shebang := $(she)$(bang)
at := @
dollar := $$
doublequote := \"
define newline

endef

CC ?= gcc
CXX ?= g++
LD ?= ld

CFLAGS ?= -Wall -std=c11
CXXFLAGS ?= $(CFLAGS) -std=c++14
LDFLAGS ?=

CFLAGS_DUMPFMT := $(CFLAGS) -I./trmm/include
LDFLAGS_DUMPFMT := $(LDFLAGS) -L./trmm/lib -lrsl -ltirpc -lfl

PLATFORM := $(shell uname)

_: all_$(PLATFORM)

all_Linux: bin/mrradard BlockBunzipper bin/dumpfmt
all_Darwin: bin/mrradard BlockBunzipper # dumpfmt wont build due to missing rpc lib

README.md_fold: README.md
	fold -s -w 100 README.md

MRRADARD_SRCDIR ?= mrradard/src
MRRADARD_OBJDIR ?= obj
MRRADARD_BINDIR ?= bin

$(MRRADARD_BINDIR)/mrradard: $(MRRADARD_BINDIR) $(MRRADARD_OBJDIR)/mrradard.o $(MRRADARD_OBJDIR)/daemon.o
	$(CC) -o $(MRRADARD_BINDIR)/mrradard $(MRRADARD_OBJDIR)/mrradard.o $(MRRADARD_OBJDIR)/daemon.o $(LDFLAGS)

$(MRRADARD_OBJDIR)/mrradard.o: $(MRRADARD_OBJDIR) $(MRRADARD_SRCDIR)/mrradard.c $(MRRADARD_SRCDIR)/daemon.h
	$(CC) -c $(MRRADARD_SRCDIR)/mrradard.c -o $(MRRADARD_OBJDIR)/mrradard.o $(CFLAGS)

$(MRRADARD_OBJDIR)/daemon.o: $(MRRADARD_OBJDIR) $(MRRADARD_SRCDIR)/daemon.c $(MRRADARD_SRCDIR)/daemon.h
	$(CC) -c $(MRRADARD_SRCDIR)/daemon.c -o $(MRRADARD_OBJDIR)/daemon.o $(CFLAGS)

bin:
	mkdir -p bin
obj:
	mkdir -p obj
.PHONY: bin obj

all: BlockBunzipper bin/dumpfmt bin/mrradard

BlockBunzipper: obj obj/BlockBunzipper.class
	echo "$(shebang)/bin/bash -x$(newline)" > BlockBunzipper
	echo 'java -cp obj BlockBunzipper $(doublequote)$(dollar)$(at)$(doublequote)' >> BlockBunzipper
	chmod +x BlockBunzipper

obj/BlockBunzipper.class: tools/BlockBunzipper.java lib/commons-compress-1.12.jar
	mkdir -p obj
	javac -cp lib/commons-compress-1.12.jar -d obj tools/BlockBunzipper.java

BlockBunzip: BlockBunzipper
	java -cp 'lib/commons-compress-1.12.jar;obj' BlockBunzipper

bin/dumpfmt: bin dumpfmt/main.c
	gcc -o bin/dumpfmt dumpfmt/main.c dumpfmt/lex.yy.c $(CFLAGS_DUMPFMT) $(LDFLAGS_DUMPFMT)

clean:
	rm -f obj/*
	rm -f BlockBunzipper bin/dumpfmt $(MRRADARD_BINDIR)/mrradard
.PHONY: clean

