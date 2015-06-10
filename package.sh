#!/bin/bash
# +AMDG
# This document was begun on 8 February 2010, the feast of
# St. John Matha, and it is humbly dedicated to him and to
# the Immaculate Heart of Mary for her prayers, and to the
# Sacred Heart of Jesus for His mercy.

tar -cvvf dozenal_v11EE0104_src.tar ./dozenal

tar -f dozenal_v11EE0104_src.tar --wildcards --verbose --delete *.o \
*.html ./dozenal/dozdc/dozdc ./dozenal/doz/doz ./dozenal/dec/dec \
./dozenal/tgmconv/tgmconv ./dozenal/dozword/dozword \
./dozenal/dozpret/dozpret ./dozenal/dozdate/dozdate \
./dozenal/dozstring/dozstring ./dozenal/dozlua/ \
./dozenal/calendar/;

gzip dozenal_v11EE0104_src.tar

tar -cvvf dozenal_v11EE0104_bin_x86.tar ./dozenal/dozstring/dozstring \
./dozenal/doz/doz ./dozenal/dec/dec ./dozenal/dozdc/dozdc \
./dozenal/dozword/dozword ./dozenal/tgmconv/tgmconv \
./dozenal/dozpret/dozpret ./dozenal/dozdate/dozdate ./dozenal/doc \
./dozenal/COPYING

tar -f dozenal_v11EE0104_bin_x86.tar --wildcards --verbose --delete \
./dozenal/doc/Makefile

gzip dozenal_v11EE0104_bin_x86.tar;
