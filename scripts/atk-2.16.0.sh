#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for atk-2.16.0
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
grep atk-2.16.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/atk/2.16/atk-2.16.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/atk/2.16/atk-2.16.0.tar.xz
#
# md5sum:
echo "c7c5002bd6e58b4723a165f1bf312116 atk-2.16.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf atk-2.16.0.tar.xz
cd atk-2.16.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf atk-2.16.0
#
# Add to installed list for this computer:
echo "atk-2.16.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################