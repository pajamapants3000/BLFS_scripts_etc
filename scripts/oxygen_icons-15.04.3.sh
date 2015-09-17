#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for oxygen_icons-15.04.3
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
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
grep oxygen_icons-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/oxygen-icons-15.04.3.tar.xz
# md5sum:
echo "4f24f975fb90d8daab833fc719ce39a3 oxygen-icons-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf oxygen-icons-15.04.3.tar.xz
cd oxygen-icons-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf oxygen-icons-15.04.3
#
# Add to installed list for this computer:
echo "oxygen_icons-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################