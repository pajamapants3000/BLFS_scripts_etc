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
#phonon-4.8.3
#vlc-2.2.1
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
grep phonon_backend_vlc-0.8.2-qt5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/phonon/phonon-backend-vlc/0.8.2/src/phonon-backend-vlc-0.8.2.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/phonon/phonon-backend-vlc/0.8.2/src/phonon-backend-vlc-0.8.2.tar.xz
#
# md5sum:
echo "3937517ce4929dea4398ad9834507f97 phonon-backend-vlc-0.8.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf phonon-backend-vlc-0.8.2.tar.xz
cd phonon-backend-vlc-0.8.2
source /usr/bin/setqt5
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_INSTALL_LIBDIR=lib     \
      -DCMAKE_BUILD_TYPE=Release     \
      -DPHONON_BUILD_PHONON4QT5=ON   \
      -D__KDE_HAVE_GCC_VISIBILITY=NO \
      -Wno-dev ..
make
#
as_root make install
cd ..
as_root rm -rf phonon-backend-vlc-0.8.2
#
# Add to installed list for this computer:
echo "phonon_backend_vlc-0.8.2-qt5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################