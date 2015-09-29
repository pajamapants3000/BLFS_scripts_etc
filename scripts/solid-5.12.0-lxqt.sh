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
grep "solid-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/frameworks/5.12/solid-5.12.0.tar.xz
# md5sum:
echo "534592c079fb90cfe8734f91d90c8fbd solid-5.12.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf solid-5.12.0.tar.xz
pushd solid-5.12.0
mkdir -v build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$LXQT_PREFIX \
      -DCMAKE_PREFIX_PATH=$QT5DIR         \
      -DCMAKE_BUILD_TYPE=Release          \
      -DLIB_INSTALL_DIR=lib               \
      -DBUILD_TESTING=OFF                 \
      -Wno-dev .. 
make
#
as_root make install
popd
as_root rm -rf solid-5.12.0
#
# Add to installed list for this computer:
echo "solid-5.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################

