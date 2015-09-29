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
#gtk+-2.24.28
# End Required
# Begin Recommended
#gtk+-3.16.6
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
grep gtk_xfce_engine-3.2.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/gtk-xfce-engine/3.2/gtk-xfce-engine-3.2.0.tar.bz2
# md5sum:
echo "363d6c16a48a00e26d45c45c2e1fd739 gtk-xfce-engine-3.2.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtk-xfce-engine-3.2.0.tar.bz2
cd gtk-xfce-engine-3.2.0
./configure --prefix=/usr --enable-gtk3
make
#
as_root make install
cd ..
as_root rm -rf gtk-xfce-engine-3.2.0
#
# Add to installed list for this computer:
echo "gtk_xfce_engine-3.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################