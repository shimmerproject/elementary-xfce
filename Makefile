#!/bin/sh

SUBDIRS := svgtopng

all: $(SUBDIRS) build

$(SUBDIRS):
	$(MAKE) -C $@

install: build
	if [ -w /usr/share/icons ]; then \
		mkdir -p /usr/share/icons/elementary-xfce && cp -R build/elementary-xfce/. /usr/share/icons/elementary-xfce; \
		mkdir -p /usr/share/icons/elementary-xfce-dark && cp -R build/elementary-xfce-dark/. /usr/share/icons/elementary-xfce-dark; \
		mkdir -p /usr/share/icons/elementary-xfce-darker && cp -R build/elementary-xfce-darker/. /usr/share/icons/elementary-xfce-darker; \
		mkdir -p /usr/share/icons/elementary-xfce-darkest && cp -R build/elementary-xfce-darkest/. /usr/share/icons/elementary-xfce-darkest; \
		gtk-update-icon-cache -f /usr/share/icons/elementary-xfce; \
		gtk-update-icon-cache -f /usr/share/icons/elementary-xfce-dark; \
		gtk-update-icon-cache -f /usr/share/icons/elementary-xfce-darker; \
		gtk-update-icon-cache -f /usr/share/icons/elementary-xfce-darkest; \
	else \
		mkdir -p ~/.local/share/icons; \
		mkdir -p ~/.local/share/icons/elementary-xfce && cp -R build/elementary-xfce/. ~/.local/share/icons/elementary-xfce; \
		mkdir -p ~/.local/share/icons/elementary-xfce-dark && cp -R build/elementary-xfce-dark/. ~/.local/share/icons/elementary-xfce-dark; \
		mkdir -p ~/.local/share/icons/elementary-xfce-darker && cp -R build/elementary-xfce-darker/. ~/.local/share/icons/elementary-xfce-darker; \
		mkdir -p ~/.local/share/icons/elementary-xfce-darkest && cp -R build/elementary-xfce-darkest/. ~/.local/share/icons/elementary-xfce-darkest; \
		gtk-update-icon-cache -f ~/.local/share/icons/elementary-xfce; \
		gtk-update-icon-cache -f ~/.local/share/icons/elementary-xfce-dark; \
		gtk-update-icon-cache -f ~/.local/share/icons/elementary-xfce-darker; \
		gtk-update-icon-cache -f ~/.local/share/icons/elementary-xfce-darkest; \
	fi

uninstall:
	if [ -w /usr/share/icons ]; then \
		rm -rf /usr/share/icons/elementary-xfce; \
		rm -rf /usr/share/icons/elementary-xfce-dark; \
		rm -rf /usr/share/icons/elementary-xfce-darker; \
		rm -rf /usr/share/icons/elementary-xfce-darkest; \
	else \
		rm -rf ~/.local/share/icons/elementary-xfce; \
		rm -rf ~/.local/share/icons/elementary-xfce-dark; \
		rm -rf ~/.local/share/icons/elementary-xfce-darker; \
		rm -rf ~/.local/share/icons/elementary-xfce-darkest; \
	fi

build: builddir
	chmod +x ./svgtopng/pngtheme.sh
	./svgtopng/pngtheme.sh build/elementary-xfce
	./svgtopng/pngtheme.sh build/elementary-xfce-dark
	./svgtopng/pngtheme.sh build/elementary-xfce-darker
	./svgtopng/pngtheme.sh build/elementary-xfce-darkest

builddir:
	mkdir -p build
	mkdir -p build/elementary-xfce && cp -R elementary-xfce/. build/elementary-xfce
	mkdir -p build/elementary-xfce-dark && cp -R elementary-xfce-dark/. build/elementary-xfce-dark
	mkdir -p build/elementary-xfce-darker && cp -R elementary-xfce-darker/. build/elementary-xfce-darker
	mkdir -p build/elementary-xfce-darkest && cp -R elementary-xfce-darkest/. build/elementary-xfce-darkest

.PHONY: all $(SUBDIRS)

clean:
	rm -rf ./build
	rm -rf ./svgtopng/svgtopng
