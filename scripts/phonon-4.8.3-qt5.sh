#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#glib-2.44.1
#qt-5.5.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pulseaudio-6.0
#qzeitgeist 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep phonon-4.8.3-qt5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/phonon/4.8.3/src/phonon-4.8.3.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/phonon/4.8.3/src/phonon-4.8.3.tar.xz
#
# md5sum:
echo "88bb9867261803eed61ff53a7c026338 phonon-4.8.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf phonon-4.8.3.tar.xz
cd phonon-4.8.3
# Link to Qt5 version
source /usr/bin/setqt5
sed -i "s:BSD_SOURCE:DEFAULT_SOURCE:g" cmake/FindPhononInternal.cmake
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_BUILD_TYPE=Release     \
      -DCMAKE_INSTALL_LIBDIR=lib     \
      -DPHONON_BUILD_PHONON4QT5=ON   \
      -D__KDE_HAVE_GCC_VISIBILITY=NO \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf phonon-4.8.3
#
# Add to installed list for this computer:
echo "phonon-4.8.3-qt5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

