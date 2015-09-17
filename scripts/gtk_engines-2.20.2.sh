#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gtk_engines-2.20.2
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.26
# End Required
# Begin Recommended
#lua-5.3.0
# End Recommended
# Begin Optional
#which-2.20
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gtk_engines-2.20.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtk-engines/2.20/gtk-engines-2.20.2.tar.bz2
# FTP/alt Download:
#wget http://ftp.gnome.org/pub/gnome/sources/gtk-engines/2.20/gtk-engines-2.20.2.tar.bz2
#
# md5sum:
echo "5deb287bc6075dc21812130604c7dc4f gtk-engines-2.20.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtk-engines-2.20.2.tar.bz2
cd gtk-engines-2.20.2
# Added --enable-lua --with-system-lua
./configure --prefix=/usr --enable-lua --with-system-lua
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gtk-engines-2.20.2
#
# Add to installed list for this computer:
echo "gtk_engines-2.20.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################