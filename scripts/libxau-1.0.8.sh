#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxau-1.0.8
#
# Dependencies
#**************
# Begin Required
#Xorg Protocol Headers
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
grep libxau-1.0.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.8.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/lib/libXau-1.0.8.tar.bz2
#
# md5sum:
echo "685f8abbffa6d145c0f930f00703b21b libXau-1.0.8.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libXau-1.0.8.tar.bz2
cd libXau-1.0.8
./configure $XORG_CONFIG
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libXau-1.0.8
#
# Add to installed list for this computer:
echo "libxau-1.0.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################