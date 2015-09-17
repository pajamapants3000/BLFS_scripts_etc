#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qimageblitz-0.0.6
#
# Dependencies
#**************
# Begin Required
# End Required
#cmake-3.3.1
#qt-4.8.7 
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
grep qimageblitz-0.0.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/qimageblitz/qimageblitz-0.0.6.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/qimageblitz/qimageblitz-0.0.6.tar.bz2
#
# md5sum:
echo "0ae2f7d4e0876764a97ca73799f61df4 qimageblitz-0.0.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qimageblitz-0.0.6.tar.bz2
cd qimageblitz-0.0.6
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf qimageblitz-0.0.6
#
# Add to installed list for this computer:
echo "qimageblitz-0.0.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################