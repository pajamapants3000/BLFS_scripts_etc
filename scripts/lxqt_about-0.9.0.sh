#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxqt_about-0.9.0
#
# Dependencies
#**************
# Begin Required
#liblxqt-0.9.0
#kwindowsystem
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
grep "lxqt_about-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-about-0.9.0.tar.xz
# md5sum:
echo "8a9ea5b780101b071911a84bb258675d lxqt_about-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt_about-0.9.0.tar.xz
cd lxqt_about-0.9.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt_about-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_about-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

