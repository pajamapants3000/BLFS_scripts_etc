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
#librsvg-2.40.10
#libxklavier-5.4
#xfce4_panel-4.12.0
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
grep xfce4_xkb_plugin-0.7.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/panel-plugins/xfce4-xkb-plugin/0.7/xfce4-xkb-plugin-0.7.1.tar.bz2
# md5sum:
echo "2f68e0d53baf68ecc1a7165ad33c26a9 xfce4-xkb-plugin-0.7.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-xkb-plugin-0.7.1.tar.bz2
cd xfce4-xkb-plugin-0.7.1
./configure --prefix=/usr --disable-debug
make
#
as_root make install
cd ..
as_root rm -rf xfce4-xkb-plugin-0.7.1
#
# Add to installed list for this computer:
echo "xfce4_xkb_plugin-0.7.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################