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
#gtk+-3.16.6
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
# End Recommended
# Begin Optional
#vala-0.28.1
#glade
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
grep gtksourceview-3.16.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtksourceview/3.16/gtksourceview-3.16.1.tar.xz
# FTP/alt Download:
#wget  ftp://ftp.gnome.org/pub/gnome/sources/gtksourceview/3.16/gtksourceview-3.16.1.tar.xz
#
# md5sum:
echo "e727db8202d23a54b54b69ebc66f5331 gtksourceview-3.16.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtksourceview-3.16.1.tar.xz
cd gtksourceview-3.16.1
./configure --prefix=/usr
make
# Test (must be in graphical environment):
make check
#
as_root make install
cd ..
as_root rm -rf gtksourceview-3.16.1
#
# Add to installed list for this computer:
echo "gtksourceview-3.16.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################