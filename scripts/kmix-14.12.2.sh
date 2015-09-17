#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kmix-14.12.2
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.5
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pulseaudio-5.0
#libcanberra-0.30 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kmix-14.12.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/14.12.2/src/kmix-14.12.2.tar.xz
# md5sum:
echo "a013333accf574a84b3e2b43683f96eb kmix-14.12.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kmix-14.12.2.tar.xz
cd kmix-14.12.2
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kmix-14.12.2
#
# Add to installed list for this computer:
echo "kmix-14.12.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
