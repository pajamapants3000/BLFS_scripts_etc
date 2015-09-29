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
#doxygen-1.8.10
#graphviz-2.38.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libexif-0.6.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libexif/libexif-0.6.21.tar.bz2
#
# md5sum:
echo "27339b89850f28c8f1c237f233e05b27 libexif-0.6.21.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libexif-0.6.21.tar.bz2
cd libexif-0.6.21
./configure --prefix=/usr \
            --with-doc-dir=/usr/share/doc/libexif-0.6.21 \
            --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libexif-0.6.21
#
# Add to installed list for this computer:
echo "libexif-0.6.21" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################