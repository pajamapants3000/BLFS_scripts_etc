#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for baloo-4.14.3
#
# Dependencies
#**************
# Begin Required
#kdepimlibs-4.14.10
#kfilemetadata-4.14.3
#xapian-1.2.21
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#openssl-1.0.2d
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep baloo-4.14.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.14.3/src/baloo-4.14.3.tar.xz
# md5sum:
echo "09575539cf2c76c951a67da00bd5df5b baloo-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf baloo-4.14.3.tar.xz
cd baloo-4.14.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf baloo-4.14.3
#
# Add to installed list for this computer:
echo "baloo-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################