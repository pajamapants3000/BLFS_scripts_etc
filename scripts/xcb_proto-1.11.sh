#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xcb-proto-1.11
#
# Dependencies
#**************
# Begin Required
#Xorg build environment
##python-2.7.9
#python-3.4.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libxml2-2.9.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xcb-proto-1.11 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.bz2
# md5sum:
echo "6bf2797445dc6d43e9e4707c082eff9c xcb-proto-1.11.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-proto-1.11.tar.bz2
cd xcb-proto-1.11
./configure $XORG_CONFIG
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf xcb-proto-1.11
#
# Add to installed list for this computer:
echo "xcb-proto-1.11" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################