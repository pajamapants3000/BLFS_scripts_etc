#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libjpeg_turbo-1.4.1
#
# Dependencies
#**************
# Begin Required
##nasm-2.11.08
#yasm-1.3.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libjpeg_turbo-1.4.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.4.1.tar.gz
# md5sum:
echo "b1f6b84859a16b8ebdcda951fa07c3f2 libjpeg-turbo-1.4.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libjpeg-turbo-1.4.1.tar.gz
cd libjpeg-turbo-1.4.1
sed -i -e '/^docdir/ s:$:/libjpeg-turbo-1.4.1:' Makefile.in
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-jpeg8            \
            --disable-static
make
# Test:
make test
#
as_root rm -f /usr/lib/libjpeg.so*
as_root make install
cd ..
as_root rm -rf libjpeg-turbo-1.4.1
#
# Add to installed list for this computer:
echo "libjpeg_turbo-1.4.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
