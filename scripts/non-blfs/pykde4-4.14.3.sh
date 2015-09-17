#!/bin/bash -ev
# Installation script for pykde4-4.14.3
#
# Dependencies
#**************
# Begin Required
#python-2.7.1
#python-3.2.0
#sip-4.12.2
#kde4
#pyqt-4.8.4
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
grep pykde4-4.14.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.14.3/src/pykde4-4.14.3.tar.xz
# FTP/alt Download:
#wget http://mirrors-usa.go-parts.com/kde/stable/4.14.3/src/pykde4-4.14.3.tar.xz
#
# md5sum:
echo "945a7492f1ab8cc874e0822f62484b12 pykde4-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pykde4-4.14.3.tar.xz
cd pykde4-4.14.3
mkdir build
cd    build
cmake -DPYTHON_EXECUTABLE=/usr/bin/python3 \
      -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX   \
      -DCMAKE_BUILD_TYPE=Release           \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf pykde4-4.14.3
#
# Add to installed list for this computer:
echo "pykde4-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
