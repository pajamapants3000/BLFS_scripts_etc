#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libepoxy-1.3.1
#
# Dependencies
#**************
# Begin Required
#mesa-10.6.5
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
grep libepoxy-1.3.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/anholt/libepoxy/releases/download/v1.3.1/libepoxy-1.3.1.tar.bz2
# md5sum:
echo "96f6620a9b005a503e7b44b0b528287d libepoxy-1.3.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libepoxy-1.3.1.tar.bz2
cd libepoxy-1.3.1
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libepoxy-1.3.1
#
# Add to installed list for this computer:
echo "libepoxy-1.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################