#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xcb_util_keysyms-0.4.0
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
grep xcb_util_keysyms-0.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2
# md5sum:
echo "1022293083eec9e62d5659261c29e367 xcb-util-keysyms-0.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcb-util-keysyms-0.4.0.tar.bz2
cd xcb-util-keysyms-0.4.0
./configure $XORG_CONFIG
make
# Test:
LD_LIBRARY_PATH=$XORG_PREFIX/lib make check
#
as_root make install
cd ..
as_root rm -rf xcb-util-keysyms-0.4.0
#
# Add to installed list for this computer:
echo "xcb_util_keysyms-0.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################