#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gsettings_desktop_schemas-3.16.1
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
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
grep gsettings_desktop_schemas-3.16.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget  http://ftp.gnome.org/pub/gnome/sources/gsettings-desktop-schemas/3.16/gsettings-desktop-schemas-3.16.1.tar.xz
# FTP/alt Download:
#wget  ftp://ftp.gnome.org/pub/gnome/sources/gsettings-desktop-schemas/3.16/gsettings-desktop-schemas-3.16.1.tar.xz
#
# md5sum:
echo "baebbcf3c20591f98876e42fb0a3fd35 gsettings-desktop-schemas-3.16.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gsettings-desktop-schemas-3.16.1.tar.xz
cd gsettings-desktop-schemas-3.16.1
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf gsettings-desktop-schemas-3.16.1
#
# Add to installed list for this computer:
echo "gsettings_desktop_schemas-3.16.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################