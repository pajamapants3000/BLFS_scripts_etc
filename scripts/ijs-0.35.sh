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
grep ijs-0.35 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.openprinting.org/download/ijs/download/ijs-0.35.tar.bz2
# md5sum:
echo "896fdcb7a01c586ba6eb81398ea3f6e9 ijs-0.35.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ijs-0.35.tar.bz2
cd ijs-0.35
./configure --prefix=/usr \
            --mandir=/usr/share/man \
            --enable-shared \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf ijs-0.35
#
# Add to installed list for this computer:
echo "ijs-0.35" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################