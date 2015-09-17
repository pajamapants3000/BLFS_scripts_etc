#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for exiv2-0.25
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#cURL-7.43.0
# End Recommended
# Begin Optional
#libssh
#doxygen-1.8.10
#graphviz-2.38.0
#python-3.4.3
#libxslt-1.1.28
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep exiv2-0.25 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.exiv2.org/exiv2-0.25.tar.gz
# md5sum:
echo "258d4831b30f75a01e0234065c6c2806 exiv2-0.25.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf exiv2-0.25.tar.gz
cd exiv2-0.25
./configure --prefix=/usr     \
            --enable-video    \
            --enable-webready \
            --without-ssh     \
            --disable-static
make
#
as_root make install
as_root chmod -v 755 /usr/lib/libexiv2.so
cd ../..
as_root rm -rf exiv2-0.25
#
# Add to installed list for this computer:
echo "exiv2-0.25" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
