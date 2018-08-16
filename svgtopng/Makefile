#!/bin/sh

ICONDIR ?= elementary-xfce

all: svgtopng

svgtopng:
	gcc -Wall -Werror -O0 -pipe \
	svgtopng.c -o svgtopng \
	`pkg-config --libs --cflags gtk+-2.0` \
	`pkg-config --libs --cflags gdk-pixbuf-2.0`

convert: svgtopng | $(ICONDIR)
	chmod +x pngtheme.sh
	./pngtheme.sh $(ICONDIR)

clean:
	rm -f svgtopng
