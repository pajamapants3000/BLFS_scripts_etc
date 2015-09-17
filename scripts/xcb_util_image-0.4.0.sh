#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xcb_util_image-0.4.0
#
# Dependencies
#**************
# Begin Required
#xcb_util-0.4.0
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
grep xcb_util_image-0.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2
# md5sum:
echo "08fe8ffecc8d4e37c0ade7906b3f4c87 xcb-util-image-0.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-util-image-0.4.0.tar.bz2
cd xcb-util-image-0.4.0
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xcb-util-image-0.4.0
#
# Add to installed list for this computer:
echo "xcb_util_image-0.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################