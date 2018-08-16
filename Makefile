PREFIX=/usr
DESTDIR=

SUBDIRS := svgtopng

all: $(SUBDIRS) build

$(SUBDIRS):
	$(MAKE) -C $@

install: build
	install -d $(DESTDIR)/$(PREFIX)/share/icons
	cp -rf build/elementary-xfce $(DESTDIR)/$(PREFIX)/share/icons
	cp -rf build/elementary-xfce-dark $(DESTDIR)/$(PREFIX)/share/icons
	cp -rf build/elementary-xfce-darker $(DESTDIR)/$(PREFIX)/share/icons
	cp -rf build/elementary-xfce-darkest $(DESTDIR)/$(PREFIX)/share/icons
	@echo \nThe icon-theme cache has not yet been regenerated, which means your changes may not be visible yet. Please run 'make icon-caches' next.

uninstall:
	rm -rf $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce
	rm -rf $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-dark
	rm -rf $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-darker
	rm -rf $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-darkest

icon-caches:
	gtk-update-icon-cache -f $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce
	gtk-update-icon-cache -f $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-dark
	gtk-update-icon-cache -f $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-darker
	gtk-update-icon-cache -f $(DESTDIR)/$(PREFIX)/share/icons/elementary-xfce-darkest

build: builddir
	chmod +x ./svgtopng/pngtheme.sh
	@./svgtopng/pngtheme.sh build/elementary-xfce
	@./svgtopng/pngtheme.sh build/elementary-xfce-dark
	@./svgtopng/pngtheme.sh build/elementary-xfce-darker
	@./svgtopng/pngtheme.sh build/elementary-xfce-darkest
	@echo == Optimizing all icon pngs
	@find build -type f -iname '*.png' | xargs optipng -strip all -silent

builddir:
	mkdir -p build
	mkdir -p build/elementary-xfce && cp -R elementary-xfce/. build/elementary-xfce
	mkdir -p build/elementary-xfce-dark && cp -R elementary-xfce-dark/. build/elementary-xfce-dark
	mkdir -p build/elementary-xfce-darker && cp -R elementary-xfce-darker/. build/elementary-xfce-darker
	mkdir -p build/elementary-xfce-darkest && cp -R elementary-xfce-darkest/. build/elementary-xfce-darkest

.PHONY: all $(SUBDIRS)

clean:
	rm -rf ./build
	rm -rf ./Makefile
	rm -rf ./svgtopng/svgtopng
