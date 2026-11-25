VERSION = "0.7.0-git"
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
PKG_CONFIG ?= pkg-config
WAYLAND_SCANNER ?= wayland-scanner
CFLAGS ?= -g -O2
CDEFS = -DVERSION='$(VERSION)' -D_XOPEN_SOURCE=700
WAYLAND_PROTOCOLS_DIR != $(PKG_CONFIG) --variable=pkgdatadir wayland-protocols
LIBRARIES = wayland-client wayland-cursor xkbcommon fontconfig
PKG_CFLAGS != $(PKG_CONFIG) --cflags $(LIBRARIES)
PKG_LIBS != $(PKG_CONFIG) --libs $(LIBRARIES)
LIBS = -lm -lutil $(PKG_LIBS)

PROTOCOLS = xdg-shell xdg-decoration-unstable-v1 primary-selection-unstable-v1 viewporter fractional-scale-v1
HEADERS = $(addprefix build/,$(addsuffix .h,$(PROTOCOLS)))
PROTOCOL_OBJS = $(addprefix build/,$(addsuffix .o,$(PROTOCOLS)))
TSM_SOURCES = $(wildcard tsm/*.c)
TSM_OBJS = $(patsubst tsm/%.c,build/tsm/%.o,$(TSM_SOURCES))
OBJ = build/main.o build/glyph.o $(PROTOCOL_OBJS) $(TSM_OBJS)

all: build/hermes

build/hermes: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LIBS)

build/main.o: $(HEADERS)
build/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(PKG_CFLAGS) $(CFLAGS) $(CDEFS) -Ibuild -MMD -MP -c $< -o $@

build/%.o: build/%.c
	$(CC) $(CPPFLAGS) $(PKG_CFLAGS) $(CFLAGS) $(CDEFS) -MMD -MP -c $< -o $@

build/%.h: build/%.xml
	$(WAYLAND_SCANNER) client-header < $< > $@

build/%.c: build/%.xml
	$(WAYLAND_SCANNER) private-code < $< > $@

build/xdg-shell.xml: $(WAYLAND_PROTOCOLS_DIR)/stable/xdg-shell/xdg-shell.xml
build/xdg-decoration-unstable-v1.xml: $(WAYLAND_PROTOCOLS_DIR)/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml
build/primary-selection-unstable-v1.xml: $(WAYLAND_PROTOCOLS_DIR)/unstable/primary-selection/primary-selection-unstable-v1.xml
build/viewporter.xml: $(WAYLAND_PROTOCOLS_DIR)/stable/viewporter/viewporter.xml
build/fractional-scale-v1.xml: $(WAYLAND_PROTOCOLS_DIR)/staging/fractional-scale/fractional-scale-v1.xml

build/%.xml:
	@mkdir -p build
	cp $< $@

install: build/hermes
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 build/hermes $(DESTDIR)$(BINDIR)/hermes

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/hermes

clean:
	rm -rf build

-include $(wildcard $(OBJ:.o=.d))
.SECONDARY:
.PHONY: all install uninstall clean
