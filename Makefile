TARGET=azpainter
APP=$(TARGET).app
VERSION=1.0.7
PATCH=$(TARGET).patch
SRCDIR=$(TARGET)-$(VERSION)
SRCOBJ=$(SRCDIR)/$(TARGET)
DLFILE=$(SRCDIR).tar.bz2
URL="https://osdn.jp/frs/redir.php?m=iij&f=%2Fazpainter%2F64397%2Fazpainter-1.0.7.tar.bz2"

.PHONY: all

all: $(TARGET)

$(TARGET): $(SRCOBJ)

$(SRCOBJ): $(PATCH) $(DLFILE)
	mkdir -p $(SRCDIR)
	tar xf $(DLFILE)
	cd $(SRCDIR) && patch -p0 -r ./ < ../$(PATCH)
	$(MAKE) -C $(SRCDIR)

$(DLFILE):
	curl -L $(URL) -o $(DLFILE)

install: $(TARGET)
	$(MAKE) install -C $(SRCDIR)

clean:
	rm -rf $(SRCDIR) $(DLFILE)
