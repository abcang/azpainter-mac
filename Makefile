TARGET=azpainter
APP=$(TARGET).app
VERSION=2.1.6
PATCH=$(TARGET).patch
SRCDIR=$(TARGET)-$(VERSION)
SRCOBJ=$(SRCDIR)/src/$(TARGET)
DLFILE=$(SRCDIR).tar.gz
URL="https://github.com/Symbian9/azpainter/archive/v$(VERSION).tar.gz"

appname := $(shell sed -n '/^Name=/s///p' $(SRCDIR)/desktop/applications/azpainter.desktop).app
locale := $(shell defaults read -g AppleLocale | sed 's/@.*$$//g').UTF-8
bin_path := /usr/local/bin/azpainter

.PHONY: all

all: $(TARGET)

$(TARGET): $(SRCOBJ)

$(SRCOBJ): $(PATCH) $(DLFILE)
	mkdir -p $(SRCDIR)
	tar xf $(DLFILE)
	cd $(SRCDIR) && chmod +x ./configure
	cd $(SRCDIR) && patch -p0 -t -r ./ < ../$(PATCH)
	cd $(SRCDIR) && ./configure
	$(MAKE) -j$(shell sysctl -n hw.ncpu) -C $(SRCDIR)

$(DLFILE):
	curl -L $(URL) -o $(DLFILE)

install:
	$(MAKE) install -C $(SRCDIR)
	echo "do shell script \"LANG=$(locale) $(bin_path) >/dev/null 2>&1 &\"" | osacompile -o $(appname)
	svg2png $(SRCDIR)/desktop/icons/hicolor/scalable/apps/azpainter.svg /tmp/azpainter_1024.png
	mkdir /tmp/azpainter.iconset
	sips -z 16 16     /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_16x16.png
	sips -z 32 32     /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_16x16@2x.png
	sips -z 32 32     /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_32x32.png
	sips -z 64 64     /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_32x32@2x.png
	sips -z 128 128   /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_128x128.png
	sips -z 256 256   /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_128x128@2x.png
	sips -z 256 256   /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_256x256.png
	sips -z 512 512   /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_256x256@2x.png
	sips -z 512 512   /tmp/azpainter_1024.png --out /tmp/azpainter.iconset/icon_512x512.png
	cp /tmp/azpainter_1024.png /tmp/azpainter.iconset/icon_512x512@2x.png
	iconutil -c icns /tmp/azpainter.iconset
	cp /tmp/azpainter.icns $(appname)/Contents/Resources/applet.icns

	rm -R /tmp/azpainter.iconset
	rm /tmp/azpainter.icns
	rm /tmp/azpainter_1024.png

	cp -rf $(appname) /Applications/

uninstall:
	$(MAKE) uninstall -C $(SRCDIR)
	rm -rf $(appname)
	rm -rf /Applications/$(appname)

clean:
	rm -rf $(SRCDIR) $(DLFILE)

