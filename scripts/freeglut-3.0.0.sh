#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for freeglut-3.0.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#mesa-10.6.5 
# End Required
# Begin Recommended
#glu-9.0.0
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
grep freeglut-3.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz
# md5sum:
echo "90c3ca4dd9d51cf32276bc5344ec9754 freeglut-3.0.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf freeglut-3.0.0.tar.gz
cd freeglut-3.0.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr      \
      -DCMAKE_BUILD_TYPE=Release       \
      -DFREEGLUT_BUILD_DEMOS=OFF       \
      -DFREEGLUT_BUILD_STATIC_LIBS=OFF \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf freeglut-3.0.0
#
# Add to installed list for this computer:
echo "freeglut-3.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################