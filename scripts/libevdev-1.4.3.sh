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
#python-2.7.10 or python-3.4.3 
# End required
# Begin recommended
# End recommended
# Begin optional
#check-0.9.14
#doxygen-1.8.10, and valgrind-3.10.1
# End optional
# Begin kernel
#CONFIG_INPUT
#CONFIG_INPUT_EVDEV
#CONFIG_INPUT_MISC
#CONFIG_INPUT_UINPUT
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libevdev-1.4.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/libevdev/libevdev-1.4.3.tar.xz
# md5sum:
echo "2fc170e2d6f543ba26e7c79f95dc1935 libevdev-1.4.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libevdev-1.4.3.tar.xz
cd libevdev-1.4.3
./configure $XORG_CONFIG
make
# Test (too much trouble!):
#make check
#
as_root make install
cd ..
as_root rm -rf libevdev-1.4.3
#
# Add to installed list for this computer:
echo "libevdev-1.4.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
