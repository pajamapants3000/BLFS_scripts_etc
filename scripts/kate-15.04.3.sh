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
#kde_frameworks-5.12.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libgit2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kate-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kate-15.04.3.tar.xz
# Alt/FTP Download
#wget ftp://ftp.kde.org/pub/kde/stable/15.04.3/src/kate-15.04.3.tar.xz
# md5sum:
echo "e044aa354b87920be84dc025c7ec060d kate-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kate-15.04.3.tar.xz
cd kate-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX  \
      -DCMAKE_BUILD_TYPE=Release          \
      -DLIB_INSTALL_DIR=lib               \
      -DBUILD_TESTING=OFF                 \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kate-15.04.3
#
# Add to installed list for this computer:
echo "kate-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################