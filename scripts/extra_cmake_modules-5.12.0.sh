#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for extra_cmake_modules-5.12.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#sphinx
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "extra_cmake_modules-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/frameworks/5.12/extra-cmake-modules-5.12.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/frameworks/5.12//extra-cmake-modules-5.12.0.tar.xz
#
# md5sum:
echo "e4042cf258b545267d74b0cf7d756150 extra-cmake-modules-5.12.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf extra-cmake-modules-5.12.0.tar.xz
cd extra-cmake-modules-5.12.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
#
as_root make install
cd ../..
as_root rm -rf extra-cmake-modules-5.12.0
#
# Add to installed list for this computer:
echo "extra_cmake_modules-5.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
