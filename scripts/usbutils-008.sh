#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for usbutils-008
#
# Dependencies
#**************
# Begin Required
#libusb-1.0.19
#python-2.7.9
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
grep usbutils-008 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.kernel.org/pub/linux/utils/usb/usbutils/usbutils-008.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kernel.org/pub/linux/utils/usb/usbutils/usbutils-008.tar.xz
#
# md5sum:
echo "2780b6ae21264c888f8f30fb2aab1259 usbutils-008.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf usbutils-008.tar.xz
cd usbutils-008
sed -i '/^usbids/ s:usb.ids:hwdata/&:' lsusb.py
./configure --prefix=/usr --datadir=/usr/share/hwdata
make
#
as_root make install
cd ..
as_root rm -rf usbutils-008
#
# Add to installed list for this computer:
echo "usbutils-008" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Configuration
#
# Get updated usb.ids file
as_root install -dm755 /usr/share/hwdata/
as_root wget http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids
#
###################################################