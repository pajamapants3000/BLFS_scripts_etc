#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kde_base_artwork-15.04.3
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
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
grep kde_base_artwork-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kde-base-artwork-15.04.3.tar.xz
# md5sum:
echo "e1a159440e9b23fccecc04b68a56f109 kde-base-artwork-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kde-base-artwork-15.04.3.tar.xz
cd kde-base-artwork-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kde-base-artwork-15.04.3
#
# Add to installed list for this computer:
echo "kde_base_artwork-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################