#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kwindowsystem-5.12.0
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
grep kwindowsystem-5.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/frameworks/5.12/kwindowsystem-5.12.0.tar.xz
#
# md5sum:
echo "001095e87ba8a52932f780bb043429d5 kwindowsystem-5.12.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kwindowsystem-5.12.0.tar.xz
cd kwindowsystem-5.12.0
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
as_root rm -rf kwindowsystem-5.12.0
#
# Add to installed list for this computer:
echo "kwindowsystem-5.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
