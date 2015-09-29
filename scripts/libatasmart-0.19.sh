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
grep libatasmart-0.19 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://0pointer.de/public/libatasmart-0.19.tar.xz
#
# md5sum:
echo "53afe2b155c36f658e121fe6def33e77 libatasmart-0.19.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libatasmart-0.19.tar.xz
cd libatasmart-0.19
./configure --prefix=/usr --disable-static
make
#
as_root make docdir=/usr/share/doc/libatasmart-0.19 install
cd ..
as_root rm -rf libatasmart-0.19
#
# Add to installed list for this computer:
echo "libatasmart-0.19" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################