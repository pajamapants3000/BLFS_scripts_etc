#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xcb_util_renderutil-0.3.9
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
grep xcb_util_renderutil-0.3.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2
# md5sum:
echo "468b119c94da910e1291f3ffab91019a xcb-util-renderutil-0.3.9.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-util-renderutil-0.3.9.tar.bz2
cd xcb-util-renderutil-0.3.9
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xcb-util-renderutil-0.3.9
#
# Add to installed list for this computer:
echo "xcb_util_renderutil-0.3.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################