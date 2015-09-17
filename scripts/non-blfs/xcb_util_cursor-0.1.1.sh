#!/bin/bash -ev
# Updated 07/19/2015
#
# Installation script for xcb-util-cursor-0.1.1
# Required To Build:
#    x11/xcb-util
#    x11/xcb-util-renderutil
#    x11/xcb-util-image
#    devel/gperf
#    devel/gmake
#    devel/pkgconf
#    devel/xorg-macros
#    x11/libxcb
# Required To Run:
#    x11/xcb-util
#    x11/xcb-util-renderutil
#    x11/xcb-util-image
#    x11/libxcb
#
# Check for previous installation:
PROCEED="yes"
grep xcb-util-cursor-0.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.1.tar.gz
#
tar -xvf xcb-util-cursor-0.1.1.tar.gz
cd xcb-util-cursor-0.1.1
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xcb-util-cursor-0.1.1
# Add to list of installed programs on this system
echo "xcb-util-cursor-0.1.1" >> /list-$CHRISTENED"-"$SURNAME
#