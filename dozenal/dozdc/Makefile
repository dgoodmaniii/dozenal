# +AMDG
# This document was begun on 15 January 2010, the feast of
# St. Paul the Hermit, and it is humbly dedicated to him and
# to the Immaculate Heart of Mary for their prayers, and to
# the Sacred Heart of Jesus for His mercy.
#
# Changes 12/2014 by Nathan Fisher <nfisher.sr@gmx.com>

prefix ?= /usr/local
# imgdir ?= $(prefix)/share/pixmaps
bindir ?= $(prefix)/bin
binmode = 755
dirmode = 755
IDIR =../include
XFORMS_FLAGS =-DXFORMS
CC = gcc
objects = main.o getop.o vars.o stack.o shunt.o xdozbc.o dozbc.o
binobjects = dozdc gdozdc
ifeq ($(XFORMS_FLAGS),-DXFORMS)
	XFORM_OBJS = shunt.o dozbc.o xdozbc.o
	XFORM_LIBS = -lforms
else
	XFORM_OBJS = 
	XFORM_LIBS = 
endif

all: bin

dozdc : main.o ../dec/dec.o $(IDIR)/dozdc.h getop.o stack.o vars.o \
	$(XFORM_OBJS)
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -o dozdc main.o ../conv/conv.o \
		../doz/doz.o ../dec/dec.o getop.o stack.o $(IDIR)/stack.h \
		vars.o $(IDIR)/vars.h $(XFORM_OBJS) $(XFORM_LIBS) -lm
	cp dozdc dozbc

main.o : main.c ../dec/dec.o $(IDIR)/dozdc.h stack.o vars.o
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -c main.c

xdozbc.o : dozbc.o dozbc.h xdozbc.c shunt.c
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -lm -c xdozbc.c shunt.o dozbc.o -lforms

dozbc.o : dozbc.c dozbc.h
	$(CC) $(XFORMS_FLAGS) -I$(DIR) -g -lm -c dozbc.c

shunt.o : shunt.c
	$(CC) $(XFORMS_FLAGS) -I$(DIR) -g -c shunt.c

getop.o : getop.c ../conv/conv.o ../doz/doz.o ../dec/dec.o \
		$(IDIR)/dozdc.h stack.o vars.o
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -lm -c getop.c

../doz/doz.o: ../conv/conv.o ../doz/doz.c
	$(MAKE) -C ../doz

../dec/dec.o: ../conv/conv.o ../dec/dec.c
	$(MAKE) -C ../dec

../conv/conv.o: ../conv/conv.c $(IDIR)/conv.h
	$(MAKE) -C ../conv

vars.o : vars.c $(IDIR)/vars.h stack.o
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -c vars.c

stack.o : stack.c $(IDIR)/stack.h
	$(CC) $(XFORMS_FLAGS) -I$(IDIR) -g -c stack.c

gdozdc : gdozdc.pl
	cp gdozdc.pl gdozdc

bin: $(binobjects)

installbin: $(binobjects)
	for obj in $(binobjects) ; do \
		install -m $(binmode) $${obj} $(bindir) ; done
	# cp logo_shapes_dozenal.xpm $(imgdir)

install: installbin

uninstall:
	for bin in $(binobjects) ; do \
		unlink $(bindir)/$${bin} ; done

clean:
	for obj in $(binobjects) $(objects) ; do \
		rm -f $${obj} ; done

.PHONY: bin clean install installbin uninstall
