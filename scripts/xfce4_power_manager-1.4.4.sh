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
#libnotify-0.7.6
#upower-0.9.23
#xfce4_panel-4.12.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#udisks-1.0.5
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xfce4_power_manager-1.4.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfce4-power-manager/1.4/xfce4-power-manager-1.4.4.tar.bz2
# md5sum:
echo "e7d00548e58bf19229e727818184c1e0 xfce4-power-manager-1.4.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-power-manager-1.4.4.tar.bz2
cd xfce4-power-manager-1.4.4
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf xfce4-power-manager-1.4.4
#
# Add to installed list for this computer:
echo "xfce4_power_manager-1.4.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################