#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kactivities-4.13.3
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#nepomuk_core
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kactivities-4.13.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.13.3/src/kactivities-4.13.3.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/4.13.3/src/kactivities-4.13.3.tar.xz
#
# md5sum:
echo "e56a3aead6f418d973c0acd9c889deb8 kactivities-4.13.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kactivities-4.13.3.tar.xz
cd kactivities-4.13.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kactivities-4.13.3
#
# Add to installed list for this computer:
echo "kactivities-4.13.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################