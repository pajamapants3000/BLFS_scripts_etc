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
#Xorg Libraries
#mesa-10.6.5
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#graphviz-2.38.0
#and texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libvdpau-1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.freedesktop.org/~aplattner/vdpau/libvdpau-1.1.tar.bz2
# md5sum:
echo "11a842df9fbaad0f5f10cf553b8d5690 libvdpau-1.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libvdpau-1.1.tar.bz2
cd libvdpau-1.1
./configure $XORG_CONFIG \
            --docdir=/usr/share/doc/libvdpau-1.1
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libvdpau-1.1
#
# Add to installed list for this computer:
echo "libvdpau-1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################