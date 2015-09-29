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
#qscintilla-2.9
# End Required
# Begin Recommended
#qtermwidget-0.6.0
# End Recommended
# Begin Optional
#desktop-file-utils-0.22
#enca
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "juffed-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/BLFS/conglomeration/juffed/juffed-0.10.r71.gc3c1a3f.tar.xz
# md5sum:
echo "5d211f5aadcb3d7365b5a6127d3d275f juffed-0.10.r71.gc3c1a3f.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf juffed-0.10.r71.gc3c1a3f.tar.xz
cd juffed-0.10.r71.gc3c1a3f
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DLIB_INSTALL_DIR=/usr/lib  \
      -DBUILD_TERMINAL=ON         \
      -DUSE_QT5=true              \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf juffed-0.10.r71.gc3c1a3f
#
# Add to installed list for this computer:
echo "juffed-0.10.r71.gc3c1a3f" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

