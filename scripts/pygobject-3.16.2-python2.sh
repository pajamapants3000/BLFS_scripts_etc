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
#gobject_introspection-1.44.0
#py2cairo-1.10.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pep8
#pyflakes
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pygobject-3.16.2-python2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pygobject/3.16/pygobject-3.16.2.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/pygobject/3.16/pygobject-3.16.2.tar.xz
#
# md5sum:
echo "8a3720efa69dd2d520e0b21b5d9e7c19 pygobject-3.16.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pygobject-3.16.2.tar.xz
cd pygobject-3.16.2
# Prep if testsuite is desired
#sed -i '/d =.*MUSIC/d' tests/test_glib.py
#
mkdir python2
pushd python2
../configure --prefix=/usr --with-python=/usr/bin/python
make
popd
# Test (graphical session required):
#make -C python2 check
#
as_root make -C python2 install
cd ..
as_root rm -rf pygobject-3.16.2
#
# Add to installed list for this computer:
echo "pygobject-3.16.2-python2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################