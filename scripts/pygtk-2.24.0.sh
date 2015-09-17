#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for pygtk-2.24.0
#
# Dependencies
#**************
# Begin Required
#pygobject-2.28.6
#atk-2.14.0
#pango-1.36.8
#py2cairo-1.10.0
#gtk+-2.24.26
#libglade-2.6.4
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#numpy
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
grep pygtk-2.24.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2
#
# md5sum:
echo "a1051d5794fd7696d3c1af6422d17a49 pygtk-2.24.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pygtk-2.24.0.tar.bz2
cd pygtk-2.24.0
./configure --prefix=/usr
make
# Test (must be run from an active X display):
make check
#
as_root make install
cd ..
as_root rm -rf pygtk-2.24.0
#
# Add to installed list for this computer:
echo "pygtk-2.24.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################