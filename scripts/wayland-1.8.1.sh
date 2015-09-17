#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for wayland-1.8.1
#
# Dependencies
#**************
# Begin Required
#libffi-3.2.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
#graphviz-2.38.0
#xmlto-0.0.26
#docbook_xml-4.5
#docbook_xsl-1.78.1
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
grep "wayland-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://wayland.freedesktop.org/releases/wayland-1.8.1.tar.xz
# md5sum:
echo "6e877877c3e04cfb865cfcd0733c9ab1 wayland-1.8.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf wayland-1.8.1.tar.xz
cd wayland-1.8.1
./configure --prefix=/usr    \
            --disable-static \
            --disable-documentation
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf wayland-1.8.1
#
# Add to installed list for this computer:
echo "wayland-1.8.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
