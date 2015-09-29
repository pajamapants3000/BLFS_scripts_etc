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
grep mtdev-1.1.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2
# md5sum:
echo "52c9610b6002f71d1642dc1a1cca5ec1 mtdev-1.1.5.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf mtdev-1.1.5.tar.bz2
cd mtdev-1.1.5
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf mtdev-1.1.5
#
# Add to installed list for this computer:
echo "mtdev-1.1.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################