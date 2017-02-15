TARGET=azpainter
APP=$(TARGET).app
VERSION=2.0.1
PATCH=$(TARGET).patch
SRCDIR=$(TARGET)-$(VERSION)
SRCOBJ=$(SRCDIR)/src/$(TARGET)
DLFILE=$(SRCDIR).tar.bz2
URL="https://osdn.net/frs/redir.php?m=jaist&f=%2Fazpainter%2F67071%2Fazpainter-2.0.1.tar.bz2"

x11_lib_dir=$(shell dirname $(shell locate libX11.dylib))
x11_include_dir=$(shell dirname $(x11_lib_dir))/include
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
