LIBUSB = /c/src/libusb

CC = gcc -pipe
VERSION = 0.47
CFLAGS = -O2 -fno-rtti -fno-exceptions -DCYCFX2PROG_VERSION=\"$(VERSION)\" \
	-W -Wall -Wformat -I$(LIBUSB)/libusb
LDFLAGS = -L$(LIBUSB)/libusb/.libs -lusb-1.0
DIST_DEST = cycfx2prog-$(VERSION)

all: cycfx2prog.exe

# NOTE: Also add sources to the "dist:" target!
cycfx2prog.exe: cycfx2prog.o cycfx2dev.o
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	-rm -f *.o *.exe

distclean: clean
	-rm -f cycfx2prog

dist:
	mkdir -p "$(DIST_DEST)"
	cp Makefile "$(DIST_DEST)"
	cp cycfx2dev.cc cycfx2dev.h "$(DIST_DEST)"
	cp cycfx2prog.cc "$(DIST_DEST)"
	tar -c "$(DIST_DEST)" | gzip -9 > "cycfx2prog-$(VERSION).tar.gz"
	rm -r "$(DIST_DEST)"

.cc.o:
	$(CC) -c $(CFLAGS) $<

cycfx2dev.o: cycfx2dev.cc cycfx2dev.h
cycfx2prog.o: cycfx2prog.cc cycfx2dev.h
