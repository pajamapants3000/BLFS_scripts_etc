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
grep xclock-1.0.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/releases/individual/app/xclock-1.0.7.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/app/xclock-1.0.7.tar.bz2
#
# md5sum:
echo "6f150d063b20d08030b98c45b9bee7af xclock-1.0.7.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xclock-1.0.7.tar.bz2
cd xclock-1.0.7
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xclock-1.0.7
#
# Add to installed list for this computer:
echo "xclock-1.0.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################