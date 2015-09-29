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
#libogg-1.3.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libvorbis-1.3.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz
# md5sum:
echo "28cb28097c07a735d6af56e598e1c90f libvorbis-1.3.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libvorbis-1.3.5.tar.xz
cd libvorbis-1.3.5
./configure --prefix=/usr --disable-static
make
# Test:
make LIBS=-lm check
#
as_root make install
as_root install -v -m644 doc/Vorbis* /usr/share/doc/libvorbis-1.3.5
cd ..
as_root rm -rf libvorbis-1.3.5
#
# Add to installed list for this computer:
echo "libvorbis-1.3.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################