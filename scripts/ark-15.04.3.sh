#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for ark-15.04.3
#
# Dependencies
#**************
# Begin Required
#kde_baseapps-15.04.3
#libarchive-3.1.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#qjson-0.8.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ark-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/ark-15.04.3.tar.xz
# md5sum:
echo "e262d982aa4ce30da47a416d76c0c96e ark-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ark-15.04.3.tar.xz
cd ark-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf ark-15.04.3
#
# Add to installed list for this computer:
echo "ark-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
