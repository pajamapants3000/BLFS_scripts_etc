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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xcb_util-0.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2
# md5sum:
echo "2e97feed81919465a04ccc71e4073313 xcb-util-0.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-util-0.4.0.tar.bz2
cd xcb-util-0.4.0
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xcb-util-0.4.0
#
# Add to installed list for this computer:
echo "xcb_util-0.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################