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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libsigc++-2.4.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libsigc++/2.4/libsigc++-2.4.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libsigc++/2.4/libsigc++-2.4.1.tar.xz
#
# md5sum:
echo "55945ba6e1652f89999e910f6b52047c libsigc++-2.4.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsigc++-2.4.1.tar.xz
cd libsigc++-2.4.1
./configure --prefix=/usr
make
# Test:
#make check
#
as_root make install
cd ..
as_root rm -rf libsigc++-2.4.1
#
# Add to installed list for this computer:
echo "libsigc++-2.4.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
