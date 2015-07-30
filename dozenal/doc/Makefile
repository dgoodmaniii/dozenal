#  Makefile
#
#  Copyright 2014 Nathan Fisher <nfisher.sr@gmx.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#

prefix ?= /usr/local
mandir ?= $(prefix)/share/man
htmldir ?= $(prefix)/share/doc/dozenal
dirmode = 755
manmode = 644
progs = \
dec \
doz \
dozdate \
dozdc \
dozpret \
dozstring \
dozword \
tgmconv

all:

htmldoc:
	for prog in $(progs) ; do \
		groff -mandoc -Thtml $${prog}.1 > $${prog}.html ; done

installdirs:
	install -d -m $(dirmode) $(mandir)/man1

installhtmldirs:
	install -d -m $(dirmode) $(htmldir)

install: installdirs
	for prog in $(progs) ; do \
		install -m $(manmode) $${prog}.1 $(mandir)/man1 ; done
	ln -sf dozdc.1 $(mandir)/man1/gdozdc.1

installhtml: htmldoc installhtmldirs
	for prog in $(progs) ; do \
		install -m $(manmode) $${prog}.html $(htmldir) ; done
	ln -sf dozdc.html $(htmldir)/gdozdc.html

uninstall:
	for prog in $(progs) ; do \
		unlink $(mandir)/$${prog}.1 \
		unlink $(htmldir)/$${prog}.html ; done
	rm -f $(mandir)/gdozdc.1
	rm -f $(htmldir)/gdozdc.html

clean:
	rm  -f *.html

.PHONY: htmldoc installdir installhtmldir install installhtml uninstall
