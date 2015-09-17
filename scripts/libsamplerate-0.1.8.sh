#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libsamplerate-0.1.8
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libsndfile-1.0.25
#libfftw3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libsamplerate-0.1.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.mega-nerd.com/SRC/libsamplerate-0.1.8.tar.gz
#
# md5sum:
echo "1c7fb25191b4e6e3628d198a66a84f47 libsamplerate-0.1.8.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsamplerate-0.1.8.tar.gz
cd libsamplerate-0.1.8
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make htmldocdir=/usr/share/doc/libsamplerate-0.1.8 install
cd ..
as_root rm -rf libsamplerate-0.1.8
#
# Add to installed list for this computer:
echo "libsamplerate-0.1.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################