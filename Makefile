TARGET=azpainter
APP=$(TARGET).app
VERSION=2.1.3
PATCH=$(TARGET).patch
SRCDIR=$(TARGET)-$(VERSION)
SRCOBJ=$(SRCDIR)/src/$(TARGET)
DLFILE=$(SRCDIR).tar.gz
URL="https://github.com/Symbian9/azpainter/archive/v2.1.3.tar.gz"

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

$(SRCOBJ): $(PATCH) $(DLFILE)
	mkdir -p $(SRCDIR)
	tar xf $(DLFILE)
	cd $(SRCDIR) && chmod +x ./configure
	cd $(SRCDIR) && patch -p0 -r ./ < ../$(PATCH)
	cd $(SRCDIR) && ./configure --with-freetype-dir=$(freetype_include_dir) CPPFLAGS="-I$(turbojpeg_include_dir) -I$(x11_include_dir)" LDFLAGS="-L$(x11_lib_dir) -L$(turbojpeg_lib_dir)"
	$(MAKE) -j$(shell sysctl -n hw.ncpu) -C $(SRCDIR)

$(DLFILE):
	curl -L $(URL) -o $(DLFILE)

install: $(TARGET)
	$(MAKE) install-strip -C $(SRCDIR)

uninstall:
	$(MAKE) uninstall -C $(SRCDIR)

clean:
	rm -rf $(SRCDIR) $(DLFILE)

