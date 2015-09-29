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
grep libburn-1.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://files.libburnia-project.org/releases/libburn-1.4.0.tar.gz
# md5sum:
echo "82ff94bb04e78eac9b12c7546f005d6f libburn-1.4.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libburn-1.4.0.tar.gz
cd libburn-1.4.0
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libburn-1.4.0
#
# Add to installed list for this computer:
echo "libburn-1.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################