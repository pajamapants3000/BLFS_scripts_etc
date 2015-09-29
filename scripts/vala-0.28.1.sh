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
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dbus-1.10.0
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
grep "vala-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/vala/0.28/vala-0.28.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/vala/0.28/vala-0.28.1.tar.xz
#
# md5sum:
echo "9e2e9e3dffccf8a158fa988688cd82c9 vala-0.28.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf vala-0.28.1.tar.xz
cd vala-0.28.1
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf vala-0.28.1
#
# Add to installed list for this computer:
echo "vala-0.28.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################