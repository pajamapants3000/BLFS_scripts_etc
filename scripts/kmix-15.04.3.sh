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
#kde_frameworks-5.12.0
# End Required
# Begin Recommended
#alsa_lib-1.0.29
# End Recommended
# Begin Optional
#libcanberra-0.30
#pulseaudio-6.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kmix-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kmix-15.04.3.tar.xz
# md5sum:
echo "228045200142ad716a147a0a3191afa4 kmix-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kmix-15.04.3.tar.xz
cd kmix-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DLIB_INSTALL_DIR=lib              \
      -DBUILD_TESTING=OFF                \
      -DKMIX_KF5_BUILD=1                 \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kmix-15.04.3
#
# Add to installed list for this computer:
echo "kmix-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################