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
grep attica-0.4.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/attica/attica-0.4.2.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/attica/attica-0.4.2.tar.bz2
#
# md5sum:
echo "d62c5c9489a68432e8d990dde7680c24 attica-0.4.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf attica-0.4.2.tar.bz2
cd attica-0.4.2
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DQT4_BUILD=ON                     \
      -Wno-dev ..
make
# Test:
make test
#
as_root make install
cd ../..
as_root rm -rf attica-0.4.2
#
# Add to installed list for this computer:
echo "attica-0.4.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################