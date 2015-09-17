#!/bin/bash -ev
# Installation script for libxdg_basedir-1.2.0
# Updated 07/19/2015
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
grep libxdg_basedir-1.2.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.openbsd.org/ports/distfiles/libxdg-basedir-1.2.0.tar.gz
#
tar -xvf libxdg-basedir-1.2.0.tar.gz
cd libxdg-basedir-1.2.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf libxdg_basedir-1.2.0
#
# Add to installed list for this computer:
echo "libxdg_basedir-1.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################