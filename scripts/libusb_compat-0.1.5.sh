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
#libusb-1.0.19
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
grep libusb_compat-0.1.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libusb/libusb-compat-0.1.5.tar.bz2
# md5sum:
echo "2780b6a758a1e2c2943bdbf7faf740e4 libusb-compat-0.1.5.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libusb-compat-0.1.5.tar.bz2
cd libusb-compat-0.1.5
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libusb-compat-0.1.5
#
# Add to installed list for this computer:
echo "libusb_compat-0.1.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################