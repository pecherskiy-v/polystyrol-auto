#
# Makefile:
#	Gertboard - Examples using wiringPi
#
#	Copyright (c) 2013 Gordon Henderson
#################################################################################

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O3
CC	= gcc
INCLUDE	= -I./include
CFLAGS	= $(DEBUG) -Wall $(INCLUDE) -Winline -pipe

LDFLAGS	= -L./lib
LDLIBS    = -lwiringPi -lwiringPiDev -lpthread -lm

# Should not alter anything below this line
###############################################################################

SRC	=	main.c

OBJ	=	$(SRC:.c=.o)

BINS	=	$(SRC:.c=)

all: lib $(BINS)

lib:
	@echo Building libwiringPi.so/libwiringPi.a
	@ $(MAKE) -C lib
	
main:	$(OBJ)
	$Q echo [link]
	$Q $(CC) -o $@ buttons.o $(LDFLAGS) $(LDLIBS)

.c.o:
	$Q echo [CC] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

clean:
	$Q echo [Clean]
	$Q rm -f $(OBJ) *~ core tags $(BINS)

tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)

depend:
	makedepend -Y $(SRC)

# DO NOT DELETE
