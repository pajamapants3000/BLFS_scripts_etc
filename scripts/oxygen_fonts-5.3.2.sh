#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for oxygen_fonts-5.3.2
#
# Dependencies
#**************
# Begin Required
#extra_cmake_modules-5.11.0
#fontforge-20150824
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
grep oxygen_fonts /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/plasma/5.3.2/oxygen-fonts-5.3.2.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/plasma/5.3.2/oxygen-fonts-5.3.2.tar.xz
#
# md5sum:
echo "64400527a9519e2992f1e10e9db4b966 oxygen-fonts-5.3.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf oxygen-fonts-5.3.2.tar.xz
cd oxygen-fonts-5.3.2
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DLIB_INSTALL_DIR=lib              \
      -DOXYGEN_FONT_INSTALL_DIR=/usr/share/fonts/truetype/oxygen \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf oxygen-fonts-5.3.2
#
# Add to installed list for this computer:
echo "oxygen_fonts-5.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

