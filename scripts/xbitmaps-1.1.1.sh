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
#util_macros-1.19.0
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
grep xbitmaps-1.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.1.tar.bz2
# Alt/FTP Download:
#wget ftp://ftp.x.org/pub/individual/data/xbitmaps-1.1.1.tar.bz2
# md5sum:
echo "7444bbbd999b53bec6a60608a5301f4c xbitmaps-1.1.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xbitmaps-1.1.1.tar.bz2
cd xbitmaps-1.1.1
./configure $XORG_CONFIG
#
as_root make install
cd ..
as_root rm -rf xbitmaps-1.1.1
#
# Add to installed list for this computer:
echo "xbitmaps-1.1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################