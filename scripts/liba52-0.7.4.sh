#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#djbfft
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "liba52-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://liba52.sourceforge.net/files/a52dec-0.7.4.tar.gz
# md5sum:
echo "caa9f5bc44232dc8aeea773fea56be80 a52dec-0.7.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf a52dec-0.7.4.tar.gz
cd a52dec-0.7.4
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --enable-shared         \
            --disable-static        \
            CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)"
make
# Test:
make check
#
as_root make install
as_root cp liba52/a52_internal.h /usr/include/a52dec
as_root install -v -m644 -D doc/liba52.txt \
    /usr/share/doc/liba52-0.7.4/liba52.txt
cd ..
as_root rm -rf a52dec-0.7.4
#
# Add to installed list for this computer:
echo "liba52-0.7.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

