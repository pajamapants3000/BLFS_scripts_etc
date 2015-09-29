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
grep libva-1.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/vaapi/releases/libva/libva-1.6.0.tar.bz2
# md5sum:
echo "3f1241b4080db53c120325932f393f33 libva-1.6.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libva-1.6.0.tar.bz2
cd libva-1.6.0
mkdir -p m4
autoreconf -fi
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf libva-1.6.0
#
# Add to installed list for this computer:
echo "libva-1.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
