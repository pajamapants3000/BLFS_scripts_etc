#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gdk_pixbuf-2.31.6
# Updated 07/22/2015
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
#libjpeg_turbo-1.4.1
#libpng-1.6.18 
# End Required
# Begin Recommended
#tiff-4.0.5
#Xorg Libraries
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
#jasPer-1.900.1
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
grep gdk_pixbuf-2.31.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.31/gdk-pixbuf-2.31.6.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.31/gdk-pixbuf-2.31.6.tar.xz
#
# md5sum:
echo "67219eb45ed0aba90b3158042b909d4e gdk-pixbuf-2.31.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gdk-pixbuf-2.31.6.tar.xz
cd gdk-pixbuf-2.31.6
./configure --prefix=/usr --with-x11
make
# Test: (fails with two errors - see "Times - Nyx" in LFS notebook)
#make check
#
as_root make install
cd ..
as_root rm -rf gdk-pixbuf-2.31.6
#
# Add to installed list for this computer:
echo "gdk_pixbuf-2.31.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
