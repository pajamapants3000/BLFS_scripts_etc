#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for konsole-15.04.3
#
# Dependencies
#**************
# Begin Required
#kde_frameworks-5.12.0
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
grep konsole-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/konsole-15.04.3.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/15.04.3/src/konsole-15.04.3.tar.xz
#
# md5sum:
echo "6075c8eaacc3f6dbc1c3c6b0a3090022 konsole-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf konsole-15.04.3.tar.xz
cd konsole-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DLIB_INSTALL_DIR=lib              \
      -DBUILD_TESTING=OFF                \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf konsole-15.04.3
#
# Add to installed list for this computer:
echo "konsole-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################