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
grep xfce4_notifyd-0.2.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/xfce4-notifyd/0.2/xfce4-notifyd-0.2.4.tar.bz2
#
# md5sum:
echo "094be6f29206aac8299f27084e284e88 xfce4-notifyd-0.2.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-notifyd-0.2.4.tar.bz2
cd xfce4-notifyd-0.2.4
./configure --prefix=/usr
make
#
as_root make install
# test
#notify-send -i info Information "Hi ${USER}, This is a Test"
#
cd ..
as_root rm -rf xfce4-notifyd-0.2.4
#
# Add to installed list for this computer:
echo "xfce4_notifyd-0.2.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################