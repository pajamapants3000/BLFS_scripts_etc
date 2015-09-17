#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for phonon-backend-gstreamer-4.8.2
#
# Dependencies
#**************
# Begin Required
#gstreamer-1.4.5
#libxml2-2.9.2
#phonon-4.8.3
# End Required
# Begin Recommended
#gst_plugins-base-1.4.5
#gst_plugins_good-1.4.5
#gst_plugins_bad-1.4.5
#gst_plugins_ugly-1.4.5
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
grep phonon_backend_gstreamer-4.8.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/phonon/phonon-backend-gstreamer/4.8.2/src/phonon-backend-gstreamer-4.8.2.tar.xz
# FTP/alt Download:
#wget  ftp://ftp.kde.org/pub/kde/stable/phonon/phonon-backend-gstreamer/4.8.2/src/phonon-backend-gstreamer-4.8.2.tar.xz
#
# md5sum:
echo "ce441035dc5a00ffaac9a64518ab5c62 phonon-backend-gstreamer-4.8.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf phonon_backend_gstreamer-4.8.2.tar.xz
cd phonon-backend-gstreamer-4.8.2
# qt4
source /usr/bin/setqt4
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_INSTALL_LIBDIR=lib     \
      -DCMAKE_BUILD_TYPE=Release     \
      -Wno-dev ..
make
#
as_root make install
# qt4
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
as_root rm -rf phonon-backend-gstreamer-4.8.2
#
# Add to installed list for this computer:
echo "phonon_backend_gstreamer-4.8.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################