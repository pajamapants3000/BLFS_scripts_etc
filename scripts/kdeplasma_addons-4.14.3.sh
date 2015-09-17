#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdeplasma_addons-4.14.3
#
# Dependencies
#**************
# Begin Required
#kde_workspace-4.11.21
#kdepimlibs-4.14.10 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libkexiv2-15.04.3
#qjson-0.8.1
#eigen
#ibus
#nepomuk
#marble
#qoauth
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdeplasma_addons-4.14.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.14.3/src/kdeplasma-addons-4.14.3.tar.xz
# md5sum:
echo "bf98d9bf1502ab4ff392fdd9b4703664 kdeplasma-addons-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdeplasma-addons-4.14.3.tar.xz
cd kdeplasma-addons-4.14.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdeplasma-addons-4.14.3
#
# Add to installed list for this computer:
echo "kdeplasma_addons-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################