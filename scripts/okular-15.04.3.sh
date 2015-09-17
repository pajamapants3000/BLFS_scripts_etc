#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for okular-15.04.3
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
# End Required
# Begin Recommended
#kactivities-4.13.3
#freetype-2.6
#qimageblitz-0.0.6
#tiff-4.0.5
#libjpeg_turbo-1.4.1
#poppler-0.35.0
# End Recommended
# Begin Optional
#libkexiv2-15.04.3
#activeapp
#libspectre
#libchm
#djvulibre
#libepub
#mobipocket
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep okular-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/okular-15.04.3.tar.xz
# md5sum:
echo "bac0e31a2d8b0009a470116ba7803bc4 okular-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf okular-15.04.3.tar.xz
cd okular-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf okular-15.04.3
#
# Add to installed list for this computer:
echo "okular-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################