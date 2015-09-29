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
grep automoc4-0.9.88 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/automoc4/0.9.88/automoc4-0.9.88.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/automoc4/0.9.88/automoc4-0.9.88.tar.bz2
#
# md5sum:
echo "91bf517cb940109180ecd07bc90c69ec automoc4-0.9.88.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf automoc4-0.9.88.tar.bz2
cd automoc4-0.9.88
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf automoc4-0.9.88
#
# Add to installed list for this computer:
echo "automoc4-0.9.88" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################