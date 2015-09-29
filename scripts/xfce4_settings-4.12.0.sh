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
#exo-0.10.6
#garcon-0.5.0
#libxfce4ui-4.12.1
# End Required
# Begin Required Runtime
#gnome_icon_theme-3.12.0
#lxde_icon_theme-0.5.1
# End Required Runtime
# Begin Recommended
#libcanberra-0.30
#libnotify-0.7.6
#libxklavier-5.4
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
grep xfce4_settings-4.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfce4-settings/4.12/xfce4-settings-4.12.0.tar.bz2
# md5sum:
echo "3eb9ff3862d773287f56f142ab7ec361 xfce4-settings-4.12.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-settings-4.12.0.tar.bz2
cd xfce4-settings-4.12.0
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf xfce4-settings-4.12.0
#
# Add to installed list for this computer:
echo "xfce4_settings-4.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################