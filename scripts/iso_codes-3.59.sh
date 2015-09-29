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
grep iso_codes-3.59 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://pkg-isocodes.alioth.debian.org/downloads/iso-codes-3.59.tar.xz
# md5sum:
echo "f16ea4bf101c226d6c8a253d39a9d23b iso-codes-3.59.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf iso-codes-3.59.tar.xz
cd iso-codes-3.59
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf iso-codes-3.59
#
# Add to installed list for this computer:
echo "iso_codes-3.59" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################