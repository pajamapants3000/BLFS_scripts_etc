#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lame-3.99.5
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
#dmalloc
#electric_fence
#libsndfile-1.0.25
#nasm-2.11.08
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "lame-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lame/lame-3.99.5.tar.gz
# md5sum:
echo "84835b313d4a8b68f5349816d33e07ce lame-3.99.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lame-3.99.5.tar.gz
cd lame-3.99.5
# Fix a compiler error introduced in gcc-4.9.0 on 32-bit machines
# DO NOT USE on other versions of gcc (probably never use)
#case $(uname -m) in
#    i?86) sed -i -e '/xmmintrin\.h/d' configure ;;
#esac
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep nasm > /dev/null); then
    ./configure --prefix=/usr --enable-mp3rtp --disable-static --enable-nasm
else
    ./configure --prefix=/usr --enable-mp3rtp --disable-static
fi
#
make
# Test:
make test
#
as_root make pkghtmldir=/usr/share/doc/lame-3.99.5 install
cd ..
as_root rm -rf lame-3.99.5
#
# Add to installed list for this computer:
echo "lame-3.99.5" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################

