#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for util_macros-1.19.0
#
# Dependencies
#**************
# Begin Required
#Xorg build environment
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
grep util_macros-1.19.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/releases/individual/util/util-macros-1.19.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2
#
# md5sum:
echo "1cf984125e75f8204938d998a8b6c1e1 util-macros-1.19.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf util-macros-1.19.0.tar.bz2
cd util-macros-1.19.0
./configure $XORG_CONFIG
#
as_root make install
cd ..
as_root rm -rf util-macros-1.19.0
#
# Add to installed list for this computer:
echo "util_macros-1.19.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################