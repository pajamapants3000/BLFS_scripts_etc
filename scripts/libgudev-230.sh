#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libgudev-230
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
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
grep libgudev-230 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libgudev/230/libgudev-230.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libgudev/230/libgudev-230.tar.xz
#
# md5sum:
echo "e4dee8f3f349e9372213d33887819a4d libgudev-230.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libgudev-230.tar.xz
cd libgudev-230
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf libgudev-230
#
# Add to installed list for this computer:
echo "libgudev-230" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################