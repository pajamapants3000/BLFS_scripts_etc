#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxdmcp-1.1.2
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
grep libxdmcp-1.1.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2
#
# md5sum:
echo "18aa5c1279b01f9d18e3299969665b2e libXdmcp-1.1.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libXdmcp-1.1.2.tar.bz2
cd libXdmcp-1.1.2
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf libXdmcp-1.1.2
#
# Add to installed list for this computer:
echo "libxdmcp-1.1.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################