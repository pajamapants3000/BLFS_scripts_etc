#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for polkit_qt_1-0.112.0-qt5
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#polkit-0.113
#qt-5.5.0
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
grep polkit_qt_1-0.112.0-qt5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/apps/KDE4.x/admin/polkit-qt-1-0.112.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/apps/KDE4.x/admin/polkit-qt-1-0.112.0.tar.bz2
#
# md5sum:
echo "bee71b71c12797e6fc498540a06c829b polkit-qt-1-0.112.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf polkit-qt-1-0.112.0.tar.bz2
cd polkit-qt-1-0.112.0
source /usr/bin/setqt5
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_LIBDIR=lib  \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf polkit-qt-1-0.112.0
#
# Add to installed list for this computer:
echo "polkit_qt_1-0.112.0-qt5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
