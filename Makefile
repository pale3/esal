ES_BIN=esal
PREFIX?=/usr
LIBS=$(PREFIX)/lib/$(ES_BIN)

all: install

install:
	install -d $(DESTDIR)/etc
	install -d $(DESTDIR)$(PREFIX)/{bin,lib}
	install -d $(DESTDIR)$(LIBS)/{modules,lib}
	install -m 0644 lib/* $(DESTDIR)$(LIBS)/lib
	install -m 0644 modules/* $(DESTDIR)$(LIBS)/modules
	install -m 0644 $(ES_BIN)rc.in $(DESTDIR)/etc/$(ES_BIN)rc
	@sed -e "0,/ES_DATA_PATH/ s|ES_DATA_PATH.*|ES_DATA_PATH:=\"$(LIBS)\"}|" $(ES_BIN).in > $(DESTDIR)$(PREFIX)/bin/$(ES_BIN)
	@chmod 0755 $(DESTDIR)$(PREFIX)/bin/$(ES_BIN)

uninstall:
	rm -f $(DESTDIR)/etc/$(ES_BIN)rc
	rm -rf $(DESTDIR)$(LIBS)
	rm -f $(DESTDIR)$(PREFIX)/bin/$(ES_BIN)
	@echo "leftover $(DESTDIR)/etc/$(ES_BIN)rc"

clean: uninstall

define DEVENV
	ES_DATA_PATH=$(PWD) \
	ES_VERSION=$(shell git describe --long --abbr=6 --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')
endef

demo:
	@echo $(DEVENV) ./esal.in "\$$@" > $(ES_BIN)
	@chmod 0755 $(PWD)/$(ES_BIN)

.PHONY: all install uninstall clean demo
