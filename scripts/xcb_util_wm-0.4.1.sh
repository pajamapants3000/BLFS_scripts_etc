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
#libxcb-1.11
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xcb_util_wm-0.4.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2
# md5sum:
echo "87b19a1cd7bfcb65a24e36c300e03129 xcb-util-wm-0.4.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-util-wm-0.4.1.tar.bz2
cd xcb-util-wm-0.4.1
./configure $XORG_CONFIG
make
# Test:
LD_LIBRARY_PATH=$XORG_PREFIX/lib make check
#
as_root make install
cd ..
as_root rm -rf xcb-util-wm-0.4.1
#
# Add to installed list for this computer:
echo "xcb_util_wm-0.4.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################