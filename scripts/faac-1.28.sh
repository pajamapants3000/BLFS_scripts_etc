#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for faac-1.28
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
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
grep "faac-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/faac/faac-1.28.tar.bz2
# md5sum:
echo "c5dde68840cefe46532089c9392d1df0 faac-1.28.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/faac-1.28-glibc_fixes-1.patch
#
tar -xvf faac-1.28.tar.bz2
cd faac-1.28
patch -Np1 -i ../faac-1.28-glibc_fixes-1.patch
sed -i -e '/obj-type/d' -e '/Long Term/d' frontend/main.c
./configure --prefix=/usr --disable-static
make
# Test - a simple decode and check is what we have:
#./frontend/faac -o Front_Left.mp4 /usr/share/sounds/alsa/Front_Left.wav
#faad Front_Left.mp4
#aplay Front_Left.wav
#
as_root make install
cd ..
as_root rm -rf faac-1.28
#
# Add to installed list for this computer:
echo "faac-1.28" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

