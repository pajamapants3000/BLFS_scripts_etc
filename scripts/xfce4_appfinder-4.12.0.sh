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
#garcon-0.5.0
#libxfce4ui-4.12.1
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
grep xfce4_appfinder-4.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfce4-appfinder/4.12/xfce4-appfinder-4.12.0.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "0b238b30686388c507c119b12664f1a1 xfce4-appfinder-4.12.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-appfinder-4.12.0.tar.bz2
cd xfce4-appfinder-4.12.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xfce4-appfinder-4.12.0
#
# Add to installed list for this computer:
echo "xfce4_appfinder-4.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################