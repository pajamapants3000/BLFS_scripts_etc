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
#libgudev-230
#libxfce4ui-4.12.1 
# End Required
# Begin Recommended
#libnotify-0.7.6
#startup_notification-0.12
#gvfs-1.24.2
#polkit_gnome-0.105
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
grep thunar_volman-0.8.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/thunar-volman/0.8/thunar-volman-0.8.1.tar.bz2
# md5sum:
echo "65ab6e05b2e808d1dcc8d36683a59b7e thunar-volman-0.8.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf thunar-volman-0.8.1.tar.bz2
cd thunar-volman-0.8.1
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf thunar-volman-0.8.1
#
# Add to installed list for this computer:
echo "thunar_volman-0.8.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################