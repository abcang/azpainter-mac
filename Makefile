TARGET=azpainter
APP=$(TARGET).app
VERSION=2.0.6
PATCH=$(TARGET).patch
SRCDIR=$(TARGET)-$(VERSION)
SRCOBJ=$(SRCDIR)/src/$(TARGET)
DLFILE=$(SRCDIR).tar.bz2
URL="https://osdn.net/frs/redir.php?m=iij&f=%2Fazpainter%2F67805%2Fazpainter-2.0.6.tar.bz2"
LOCALE_DIR=azpainter_mtr
LOCALE_FILE=$(LOCALE_DIR)_20170603.zip
LOCALE_FILE_URL="http://hnng.moe/f/ReA"

x11_dir=/usr/X11
x11_lib_dir=$(x11_dir)/lib
x11_include_dir=$(x11_dir)/include
freetype_include_dir=$(x11_include_dir)/freetype2
turbojpeg_dir=$(shell brew --prefix jpeg-turbo)
turbojpeg_include_dir=$(turbojpeg_dir)/include
turbojpeg_lib_dir=$(turbojpeg_dir)/lib

.PHONY: all

all: $(TARGET)

$(TARGET): $(SRCOBJ)

$(SRCOBJ): $(PATCH) $(DLFILE) $(LOCALE_FILE)
	mkdir -p $(SRCDIR)
	tar xf $(DLFILE)
	cd $(SRCDIR) && patch -p0 -r ./ < ../$(PATCH)
	cp -f $(LOCALE_DIR)/*.mtr $(SRCDIR)/data/tr
	cd $(SRCDIR) && ./configure --with-freetype-dir=$(freetype_include_dir) CPPFLAGS="-I$(turbojpeg_include_dir) -I$(x11_include_dir)" LDFLAGS="-L$(x11_lib_dir) -L$(turbojpeg_lib_dir)"
	$(MAKE) -j$(shell sysctl -n hw.ncpu) -C $(SRCDIR)

$(DLFILE):
	curl -L $(URL) -o $(DLFILE)

$(LOCALE_FILE):
	curl -L $(LOCALE_FILE_URL) -o $(LOCALE_FILE)
	unzip -o $(LOCALE_FILE)

install: $(TARGET)
	$(MAKE) install-strip -C $(SRCDIR)

uninstall:
	$(MAKE) uninstall -C $(SRCDIR)

clean:
	rm -rf $(SRCDIR) $(DLFILE)
	rm -rf $(LOCALE_DIR) $(LOCALE_FILE)

