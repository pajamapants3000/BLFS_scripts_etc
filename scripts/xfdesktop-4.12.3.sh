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
#libwnck-2.30.7
#libxfce4ui-4.12.1
# End Required
# Begin Recommended
#libnotify-0.7.6
#startup_notification-0.12
#thunar-1.6.10
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
grep xfdesktop-4.12.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfdesktop/4.12/xfdesktop-4.12.3.tar.bz2
# md5sum:
echo "cb34f4f333d7d122f1688d2f155202c8 xfdesktop-4.12.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfdesktop-4.12.3.tar.bz2
cd xfdesktop-4.12.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xfdesktop-4.12.3
#
# Add to installed list for this computer:
echo "xfdesktop-4.12.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################