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
grep liblxqt_mount-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/liblxqt-mount-0.9.0.tar.xz
#
# md5sum:
echo "476d91d6680f63b0dd7ab445120b9e20 liblxqt-mount-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf liblxqt-mount-0.9.0.tar.xz
cd liblxqt-mount-0.9.0
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DCMAKE_INSTALL_LIBDIR=lib       \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf liblxqt-mount-0.9.0
#
# Add to installed list for this computer:
echo "liblxqt_mount-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
