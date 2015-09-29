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
#kwindowsystem
#lxqt_common-0.9.1
#lxqt_globalkeys-0.9.0
#menu_cache-1.0.0
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
grep "lxqt_runner-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-runner-0.9.0.tar.xz
# md5sum:
echo "f68f8b9876bc825a2f5c9d6e9621211a lxqt-runner-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-runner-0.9.0.tar.xz
cd lxqt-runner-0.9.0
#
sed -i 's:<KF5/KWindowSystem/:<:' dialog.cpp
#
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DKF5WindowSystem_DIR=/opt/kf5/lib/cmake/KF5WindowSystem \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt-runner-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_runner-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
