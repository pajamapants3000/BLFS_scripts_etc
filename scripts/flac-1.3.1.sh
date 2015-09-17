#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for flac-1.3.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libogg-1.3.2
#nasm-2.11.08
#docbook_utils-0.6.14
#doxygen-1.8.10
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep flac-1.3.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.xiph.org/releases/flac/flac-1.3.1.tar.xz
# FTP/alt Download:
#wget ftp://downloads.xiph.org/pub/xiph/releases/flac/flac-1.3.1.tar.xz
#
# md5sum:
echo "b9922c9a0378c88d3e901b234f852698 flac-1.3.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf flac-1.3.1.tar.xz
cd flac-1.3.1
./configure --prefix=/usr \
            --disable-thorough-tests
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf flac-1.3.1
#
# Add to installed list for this computer:
echo "flac-1.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################