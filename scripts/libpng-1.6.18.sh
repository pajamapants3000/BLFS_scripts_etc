#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libpng-1.6.18
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
grep "libpng-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libpng/libpng-1.6.18.tar.xz
# optional functionality patch ownload:
wget http://downloads.sourceforge.net/libpng-apng/libpng-1.6.18-apng.patch.gz
#
# md5sum:
echo "6a57c8e0f5469b9c9949a4b43d57b3a1 libpng-1.6.18.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libpng-1.6.18.tar.xz
cd libpng-1.6.18
gzip -cd ../libpng-1.6.18-apng.patch.gz | patch -p1
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
as_root mkdir -v /usr/share/doc/libpng-1.6.18
as_root cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.18
cd ..
as_root rm -rf libpng-1.6.18
#
# Add to installed list for this computer:
echo "libpng-1.6.18" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################