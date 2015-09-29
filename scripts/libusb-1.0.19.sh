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
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
# End Optional
# Begin Kernel
#CONFIG_USB_SUPPORT
#CONFIG_USB
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libusb-1.0.19 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libusb/libusb-1.0.19.tar.bz2
# md5sum:
echo "f9e2bb5879968467e5ca756cb4e1fa7e libusb-1.0.19.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libusb-1.0.19.tar.bz2
cd libusb-1.0.19
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libusb-1.0.19
#
# Add to installed list for this computer:
echo "libusb-1.0.19" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################