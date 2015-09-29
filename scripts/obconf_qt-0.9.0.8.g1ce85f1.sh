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
#openbox-3.6.1
#qt-5.5.0
#qt-4.8.7
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
grep "obconf_qt-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/other/obconf-qt-0.9.0.8.g1ce85f1.tar.xz
# md5sum:
echo "dc0b9515fec3cf81cf809192e75daa3f obconf-qt-0.9.0.8.g1ce85f1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf obconf-qt-0.9.0.8.g1ce85f1.tar.xz
cd obconf-qt-0.9.0.8.g1ce85f1
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf obconf-qt-0.9.0.8.g1ce85f1
#
# Add to installed list for this computer:
echo "obconf-qt-0.9.0.8.g1ce85f1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

