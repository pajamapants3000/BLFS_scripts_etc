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
#poppler-0.31.0
#gtk+-2.24.26
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cups-2.0.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep epdfview-0.1.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/BLFS/conglomeration/epdfview/epdfview-0.1.8.tar.bz2
# md5sum:
echo "e50285b01612169b2594fea375f53ae4 epdfview-0.1.8.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/7.7/epdfview-0.1.8-fixes-1.patch
tar -xvf epdfview-0.1.8.tar.bz2
cd epdfview-0.1.8
patch -Np1 -i ../epdfview-0.1.8-fixes-1.patch
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf epdfview-0.1.8
#
# Add to installed list for this computer:
echo "epdfview-0.1.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################