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
#glib-2.42.1
#py2cairo-1.10.0 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.42.0
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
grep pygobject-2.28.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/pygobject-2.28.6.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/pygobject-2.28.6.tar.xz
#
# md5sum:
echo "9415cb7f2b3a847f2310ccea258b101e pygobject-2.28.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/7.7/pygobject-2.28.6-fixes-1.patch
#
tar -xvf pygobject-2.28.6.tar.xz
cd pygobject-2.28.6
patch -Np1 -i ../pygobject-2.28.6-fixes-1.patch
./configure --prefix=/usr --disable-introspection
make
#
as_root make install
cd ..
as_root rm -rf pygobject-2.28.6
#
# Add to installed list for this computer:
echo "pygobject-2.28.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################