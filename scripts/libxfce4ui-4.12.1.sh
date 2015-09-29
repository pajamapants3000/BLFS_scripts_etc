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
#gtk+-3.16.6
#xfconf-4.12.0
# End Required
# Begin Recommended
#startup_notification-0.12
# End Recommended
# Begin Optional
#gtk_doc-1.24
#html__parser-3.71
#glade 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libxfce4ui-4.12.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/libxfce4ui/4.12/libxfce4ui-4.12.1.tar.bz2
# md5sum:
echo "ea9fad7d059fe8f531fe8db42dabb5a9 libxfce4ui-4.12.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxfce4ui-4.12.1.tar.bz2
cd libxfce4ui-4.12.1
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf libxfce4ui-4.12.1
#
# Add to installed list for this computer:
echo "libxfce4ui-4.12.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################