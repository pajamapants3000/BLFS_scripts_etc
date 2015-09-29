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
#hicolor_icon_theme-0.15
#liblxqt-0.9.0
#qt-5.5.0
#upower-0.9.23
#xdg_utils-1.1.0-rc3
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
grep lxqt_powermanagement-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-powermanagement-0.9.0.tar.xz
#
# md5sum:
echo "5efa3de8ee1b8548ee59dc8f7fd773d0 lxqt-powermanagement-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-powermanagement-0.9.0.tar.xz
cd lxqt-powermanagement-0.9.0
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
as_root rm -rf lxqt-powermanagement-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_powermanagement-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
