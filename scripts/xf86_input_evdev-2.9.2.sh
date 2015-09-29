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
#libevdev-1.4.3
#xorg_server-1.17.2 
# End Required
# Begin Recommended
#mtdev-1.1.5
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
grep xf86_input_evdev-2.9.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/driver/xf86-input-evdev-2.9.2.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/driver/xf86-input-evdev-2.9.2.tar.bz2
#
# md5sum:
echo "99eebf171e6c7bffc42d4fc430d47454 xf86-input-evdev-2.9.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xf86-input-evdev-2.9.2.tar.bz2
cd xf86-input-evdev-2.9.2
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xf86-input-evdev-2.9.2
#
# Add to installed list for this computer:
echo "xf86_input_evdev-2.9.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################