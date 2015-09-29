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
#kwindowsystem-5.12.0 (may require KF5)
#libqtxdg-1.2.0
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
grep liblxqt-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/liblxqt-0.9.0.tar.xz
#
# md5sum:
echo "b027c6114d543e24a35846d37d374009 liblxqt-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Alt Download - change to gz!:
#wget https://github.com/lxde/liblxqt/archive/0.9.0.tar.gz
#
tar -xvf liblxqt-0.9.0.tar.xz
cd liblxqt-0.9.0
sed -e '/lxqtnotification.h/ i #include <QObject>' \
    -i lxqtnotification.cpp
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DCMAKE_INSTALL_LIBDIR=lib       \
      -DKF5WindowSystem_DIR=/opt/lxqt/lib/cmake/KF5WindowSystem \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf liblxqt-0.9.0
#
# Add to installed list for this computer:
echo "liblxqt-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
