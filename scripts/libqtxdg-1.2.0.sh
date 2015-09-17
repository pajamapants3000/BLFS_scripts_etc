#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libqtxdg-1.2.0
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
grep libqtxdg-1.2.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/libqtxdg/1.2.0/libqtxdg-1.2.0.tar.xz
#
# md5sum:
echo "3e92e224da807710862a0a94fad14dcd libqtxdg-1.2.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libqtxdg-1.2.0.tar.xz
cd libqtxdg-1.2.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DCMAKE_INSTALL_LIBDIR=lib       \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf libqtxdg-1.2.0
#
# Add to installed list for this computer:
echo "libqtxdg-1.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
