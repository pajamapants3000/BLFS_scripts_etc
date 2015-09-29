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
grep hicolor_icon_theme-0.15 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.15.tar.xz
# md5sum:
echo "6aa2b3993a883d85017c7cc0cfc0fb73 hicolor-icon-theme-0.15.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf hicolor-icon-theme-0.15.tar.xz
cd hicolor-icon-theme-0.15
./configure --prefix=/usr
#
as_root make install
cd ..
as_root rm -rf hicolor-icon-theme-0.15
#
# Add to installed list for this computer:
echo "hicolor_icon_theme-0.15" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################