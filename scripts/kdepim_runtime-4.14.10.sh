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
#kdepimlibs-4.14.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#kolablibraries
#libkgapi
#libkfbapi
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdepim_runtime-4.14.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kdepim-runtime-4.14.10.tar.xz
# md5sum:
echo "7dd2063acf9b6920920d0118f5576db6 kdepim-runtime-4.14.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdepim-runtime-4.14.10.tar.xz
cd kdepim-runtime-4.14.10
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdepim-runtime-4.14.10
#
# Add to installed list for this computer:
echo "kdepim_runtime-4.14.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################