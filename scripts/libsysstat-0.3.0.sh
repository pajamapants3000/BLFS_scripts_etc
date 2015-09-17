#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libsysstat-0.3.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#qt-5.5.0
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
grep libsysstat-0.3.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/libsysstat/0.3.0/libsysstat-0.3.0.tar.xz
#
# md5sum:
echo "2d9d9889ba2ed8712d34e6835001e6d0 libsysstat-0.3.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsysstat-0.3.0.tar.xz
cd libsysstat-0.3.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf libsysstat-0.3.0
#
# Add to installed list for this computer:
echo "libsysstat-0.3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
