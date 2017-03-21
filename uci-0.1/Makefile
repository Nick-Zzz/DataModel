VERSION=0.1

# optional features
PLUGIN_SUPPORT=1
DEBUG=0
DEBUG_TYPECAST=0

include ../Makefile.inc


ifeq ($(DEBUG),1)
  COPTS = -O0
  CFLAGS += -g3
endif
OS=$(shell uname)
LINK=$(CC)
SHLIB_EXT=so
SHLIB_FLAGS=-shared -Wl,-soname,$(SHLIB_FILE)

LIBS=-lc
SHLIB_FILE=libuci.$(SHLIB_EXT).$(VERSION)

define add_feature
	@echo "$(if $(findstring 1,$($(1))),#define UCI_$(1) 1,#undef UCI_$(1))" >> $@.tmp
endef

LIBUCI_DEPS=file.c history.c list.c util.c uci.h uci_config.h uci_internal.h

all: uci libuci.$(SHLIB_EXT)

cli.o: cli.c uci.h uci_config.h

uci_config.h: FORCE
	@rm -f "$@.tmp"
	$(call add_feature,PLUGIN_SUPPORT)
	$(call add_feature,DEBUG)
	$(call add_feature,DEBUG_TYPECAST)
	@if [ \! -f "$@" ] || ! cmp "$@.tmp" "$@" >/dev/null; then \
		mv "$@.tmp" "$@"; \
	else \
		rm -f "$@.tmp"; \
	fi

uci: cli.o libuci.$(SHLIB_EXT)
	$(CC) -o $@ $< -L. -luci

libuci-static.o: libuci.c $(LIBUCI_DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

libuci-shared.o: libuci.c $(LIBUCI_DEPS)
	$(CC) $(CFLAGS) $(FPIC) -c -o $@ $<

libuci.a: libuci-static.o
	rm -f $@
	$(AR) rc $@ $^
	$(RANLIB) $@

libuci.$(SHLIB_EXT): libuci-shared.o
	$(LINK) $(SHLIB_FLAGS) $(FPIC) -o $(SHLIB_FILE) $^ $(LIBS)
	ln -sf $(SHLIB_FILE) $@

clean:
	rm -f uci uci-static *.[oa] *.so* *.dylib* uci_config.h

FORCE: ;
.PHONY: FORCE
