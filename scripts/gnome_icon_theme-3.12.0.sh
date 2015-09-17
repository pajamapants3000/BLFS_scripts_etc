#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gnome_icon_theme-3.12.0
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
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
grep gnome_icon_theme-3.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz
#
# md5sum:
echo "f14bed7f804e843189ffa7021141addd gnome-icon-theme-3.12.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gnome-icon-theme-3.12.0.tar.xz
cd gnome-icon-theme-3.12.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf gnome-icon-theme-3.12.0
#
# Add to installed list for this computer:
echo "gnome_icon_theme-3.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################