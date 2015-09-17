#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libdbusmenu-qt-0.9.3+15.10.20150604-qt4
#
# Dependencies
#**************
# Begin Required
#qt-4.8.7
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#qjson-0.8.1
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libdbusmenu-qt-0.9.3+15.10.20150604-qt4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/other/libdbusmenu-qt-0.9.3+15.10.20150604.tar.xz
# md5sum:
echo "d21a1f5569e0bc9c9245b4f71761c62f libdbusmenu-qt-0.9.3+15.10.20150604.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdbusmenu-qt-0.9.3+15.10.20150604.tar.xz
cd libdbusmenu-qt-0.9.3+15.10.20150604
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DUSE_QT4=TRUE              \
      -DWITH_DOC=OFF              \
      -Wno-dev ..
make
# Test (one known to fail):
make -k check || ( exit 0 )
#
as_root make install
cd ../..
as_root rm -rf libdbusmenu-qt-0.9.3+15.10.20150604
#
# Add to installed list for this computer:
echo "libdbusmenu-qt-0.9.3+15.10.20150604-qt4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
