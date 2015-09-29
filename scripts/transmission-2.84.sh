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
#curl-7.44.0
#libevent-2.0.22
#openssl-1.0.2d
# End Required
# Begin Recommended
##gtk+-3.16.6
##qt-4.8.7
#qt-5.5.0
# End Recommended
# Begin Optional
#doxygen-1.8.10
#gdb-7.9.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep transmission-2.84 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://transmission.cachefly.net/transmission-2.84.tar.xz
# md5sum:
echo "411aec1c418c14f6765710d89743ae42 transmission-2.84.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf transmission-2.84.tar.xz
cd transmission-2.84
# Optional: --without-gtk
./configure --prefix=/usr --without-gtk
make
# Compile qt gui
#source setqt5
sed -i '/^CONFIG/aQMAKE_CXXFLAGS += -std=c++11' qt/qtr.pro
pushd qt
  qmake qtr.pro
  make
popd
#
as_root make install
# Install qt gui
as_root make INSTALL_ROOT=/usr -C qt install
as_root install -m644 qt/transmission-qt.desktop /usr/share/applications/transmission-qt.desktop &&
as_root install -m644 qt/icons/transmission.png  /usr/share/pixmaps/transmission-qt.png
cd ..
as_root rm -rf transmission-2.84
#
# Add to installed list for this computer:
echo "transmission-2.84" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################