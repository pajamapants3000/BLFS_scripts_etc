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
#extra_cmake_modules-5.12.0
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
grep kguiaddons-5.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/frameworks/5.12/kguiaddons-5.12.0.tar.xz
#
# md5sum:
echo "154b8c8a475a18ef1936e53f91ca5dff kguiaddons-5.12.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kguiaddons-5.12.0.tar.xz
cd kguiaddons-5.12.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_PREFIX_PATH=$QT5DIR        \
      -DCMAKE_BUILD_TYPE=Release         \
      -DLIB_INSTALL_DIR=lib              \
      -DBUILD_TESTING=OFF                \
      -Wno-dev .. 
make
#
as_root make install
cd ../..
as_root rm -rf kguiaddons-5.12.0
#
# Add to installed list for this computer:
echo "kguiaddons-5.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

