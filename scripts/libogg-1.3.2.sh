#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libogg-1.3.2
#
# Dependencies
#**************
# Begin Required
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
grep libogg-1.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz
# FTP/alt Download:
#wget ftp://downloads.xiph.org/pub/xiph/releases/ogg/libogg-1.3.2.tar.xz
#
# md5sum:
echo "5c3a34309d8b98640827e5d0991a4015 libogg-1.3.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libogg-1.3.2.tar.xz
cd libogg-1.3.2
./configure --prefix=/usr --docdir=/usr/share/doc/libogg-1.3.2 --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libogg-1.3.2
#
# Add to installed list for this computer:
echo "libogg-1.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################