#
# Makefile:
#	Gertboard - Examples using wiringPi
#
#	Copyright (c) 2013 Gordon Henderson
#################################################################################

DESTDIR?=/usr
PREFIX?=/local

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O3
CC	= gcc
INCLUDE+= -I.
INCLUDE+= -I./src
INCLUDE+= -I./include
INCLUDE+= -I/usr/local/include
CFLAGS	= $(DEBUG) -Wall $(INCLUDE) -Winline -pipe

LDFLAGS	= -L./lib
LDFLAGS	= -L./wiringPi
LDFLAGS+= -L/usr/local/lib
LDLIBS    = -lwiringPi -lpthread -lm -lcrypt

# Should not alter anything below this line
###############################################################################

SRC_DIR = ./src

SRCS = $(wildcard $(SRC_DIR)/*.c)

OBJECTS+=$(patsubst %.c,%.o,$(SRCS))

BINS	=	polystyrol

all: $(BINS)

$(BINS):	$(OBJECTS)
	$Q $(MAKE) -C wiringPi
	$Q echo [link]
	$Q $(CC) -o $@ $(OBJECTS) $(LDFLAGS) $(LDLIBS)

.c.o:
	$Q echo [CC] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

clean:
	$Q echo [Clean]
	$Q rm -f $(OBJ) *~ core tags $(BINS)
	$Q rm -f ./wiringPi/*.o
	$Q rm -f ./wiringPi/*.d

.PHONY:	install
install: polystyrol
	$Q echo "[Install polystyrol]"
	$Q cp polystyrol	$(DESTDIR)
	$Q chown root.root	$(DESTDIR)/polystyrol

tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)

depend:
	makedepend -Y $(SRC)

# DO NOT DELETE
