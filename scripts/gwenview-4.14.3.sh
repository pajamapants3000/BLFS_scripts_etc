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
#libkdcraw-15.04.2
#kdelibs-4.14.10
# End Required
# Begin Recommended
#kactivities-4.13.3
#kde_baseapps-15.04.3
#libkexiv2-15.04.3
#libjpeg_turbo-1.4.1
# End Recommended
# Begin Optional
#little_cms-2.7
#kipi_plugins
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gwenview-4.14.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.14.3/src/gwenview-4.14.3.tar.xz
# md5sum:
echo "a609256023f7b6e786fe7728ba299544 gwenview-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gwenview-4.14.3.tar.xz
cd gwenview-4.14.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf gwenview-4.14.3
#
# Add to installed list for this computer:
echo "gwenview-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
