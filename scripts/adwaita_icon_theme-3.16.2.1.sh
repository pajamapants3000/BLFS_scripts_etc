#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for adwaita_icon_theme-3.16.2.1
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.28
#gtk+-3.16.6
#librsvg-2.40.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#git-2.5.0
#inkscape-0.91
#icon_tools
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep adwaita_icon_theme-3.16.2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.16/adwaita-icon-theme-3.16.2.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.16/adwaita-icon-theme-3.16.2.1.tar.xz
#
# md5sum:
echo "9ef86952c947aa27a1a888b7735d60b3 adwaita-icon-theme-3.16.2.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf adwaita-icon-theme-3.16.2.1.tar.xz
cd adwaita-icon-theme-3.16.2.1
./configure --prefix=/usr
make
make
#
as_root make install
cd ..
as_root rm -rf adwaita-icon-theme-3.16.2.1
#
# Add to installed list for this computer:
echo "adwaita_icon_theme-3.16.2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################