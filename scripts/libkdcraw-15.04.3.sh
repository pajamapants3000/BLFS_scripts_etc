#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libkdcraw-15.04.3
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
#libraw-0.17.0
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
grep libkdcraw-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/libkdcraw-15.04.3.tar.xz
# md5sum:
echo "107492896bbc6bfc59657ecb5dfceefe libkdcraw-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libkdcraw-15.04.3.tar.xz
cd libkdcraw-15.04.3
sed -e '/3/a add_definitions(${KDE4_ENABLE_EXCEPTIONS})' \
        -i libkdcraw/CMakeLists.txt
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf libkdcraw-15.04.3
#
# Add to installed list for this computer:
echo "libkdcraw-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################