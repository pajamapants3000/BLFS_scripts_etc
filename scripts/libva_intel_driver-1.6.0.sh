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
#mesa-10.6.5
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#Wayland
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libva_intel_driver-1.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/libva-intel-driver-1.6.0.tar.bz2
# md5sum:
echo "d7678f7c66cbb135cced82ee2af6d8e8 libva-intel-driver-1.6.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libva-intel-driver-1.6.0.tar.bz2
cd libva-intel-driver-1.6.0
mkdir -p m4
autoreconf -fi
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf libva-intel-driver-1.6.0
#
# Add to installed list for this computer:
echo "libva_intel_driver-1.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################