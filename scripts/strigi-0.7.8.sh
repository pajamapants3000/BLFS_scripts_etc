#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for strigi-0.7.8
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
# End Required
# Begin Recommended
#d_bus-1.8.20
#qt-4.8.7 
# End Recommended
# Begin Optional
#ffmpeg-2.7.2
#exiv2-0.25
#libxml2-2.9.2
#clucene-0.9x
#log4cxx
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep strigi-0.7.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.vandenoever.info/software/strigi/strigi-0.7.8.tar.bz2
# md5sum:
echo "d69443234f4286d71997db9de543331a strigi-0.7.8.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf strigi-0.7.8.tar.bz2
cd strigi-0.7.8
sed -i "s/BufferedStream :/STREAMS_EXPORT &/" libstreams/include/strigi/bufferedstream.h
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_INSTALL_LIBDIR=lib  \
      -DCMAKE_BUILD_TYPE=Release  \
      -DENABLE_CLUCENE=OFF        \
      -DENABLE_CLUCENE_NG=OFF     \
      ..
make
# Test:
make test
#
as_root make install
cd ../..
as_root rm -rf strigi-0.7.8
#
# Add to installed list for this computer:
echo "strigi-0.7.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################