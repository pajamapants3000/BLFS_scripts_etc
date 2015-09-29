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
grep "faad2-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/faac/faad2-2.7.tar.bz2:
# md5sum:
echo "4c332fa23febc0e4648064685a3d4332 faad2-2.7.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/faad2-2.7-mp4ff-1.patch
#
tar -xvf faad2-2.7.tar.bz2
cd faad2-2.7
#
patch -Np1 -i ../faad2-2.7-mp4ff-1.patch
sed -i "s:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g" configure.in
sed -i "s:man_MANS:man1_MANS:g" frontend/Makefile.am
autoreconf -fi &&
./configure --prefix=/usr --disable-static
make
#
as_root make install
#
cd ..
as_root rm -rf faad2-2.7
#
# Add to installed list for this computer:
echo "faad2-2.7" >> /list-$CHRISTENED"-"$SURNAME
#
# Simple Test:
# Sample audio file
#wget http://www.nch.com.au/acm/sample.aac
#./frontend/faad -o sample.wav ../sample.aac
#aplay sample.wav
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################

