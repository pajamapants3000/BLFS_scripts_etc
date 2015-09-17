#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libcroco-0.6.8
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
#libxml2-2.9.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libcroco-0.6.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget  http://ftp.gnome.org/pub/gnome/sources/libcroco/0.6/libcroco-0.6.8.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libcroco/0.6/libcroco-0.6.8.tar.xz
#
# md5sum:
echo "767e73c4174f75b99695d4530fd9bb80 libcroco-0.6.8.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libcroco-0.6.8.tar.xz
cd libcroco-0.6.8
./configure --prefix=/usr --disable-static
make
# Test:
LD_LIBRARY_PATH=$(pwd)/src/.libs make test
#
as_root make install
cd ..
as_root rm -rf libcroco-0.6.8
#
# Add to installed list for this computer:
echo "libcroco-0.6.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################