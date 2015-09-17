#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libsndfile-1.0.25
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#alsa_lib-1.0.29
#flac-1.3.1
#libogg-1.3.2
#libvorbis-1.3.5
#sqlite-3.8.11.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libsndfile-1.0.25 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.25.tar.gz
# md5sum:
echo "e2b7bb637e01022c7d20f95f9c3990a2 libsndfile-1.0.25.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsndfile-1.0.25.tar.gz
cd libsndfile-1.0.25
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make htmldocdir=/usr/share/doc/libsndfile-1.0.25 install
cd ..
as_root rm -rf libsndfile-1.0.25
#
# Add to installed list for this computer:
echo "libsndfile-1.0.25" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################