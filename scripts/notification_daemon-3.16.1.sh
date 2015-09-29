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
#GTK+-3.16.6
#libcanberra-0.30
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
grep notification_daemon-3.16.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/notification-daemon/3.16/notification-daemon-3.16.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/notification-daemon/3.16/notification-daemon-3.16.1.tar.xz
#
# md5sum:
echo "8ea9ccf633c05e907e8fa9d99ca6ffd9 notification-daemon-3.16.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf notification-daemon-3.16.1.tar.xz
cd notification-daemon-3.16.1
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf notification-daemon-3.16.1
#
# Add to installed list for this computer:
echo "notification_daemon-3.16.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Test
pgrep -l notification-da &&
notify-send -i info Information "Hi ${USER}, This is a Test"
#
###################################################