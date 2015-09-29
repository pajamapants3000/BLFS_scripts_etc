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
#gtk+-2.24.26
#libpng-1.6.16
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pixman-0.32.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cairographics.org/releases/pixman-0.32.6.tar.gz
# md5sum:
echo "3a30859719a41bd0f5cccffbfefdd4c2 pixman-0.32.6.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pixman-0.32.6.tar.gz
cd pixman-0.32.6
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf pixman-0.32.6
#
# Add to installed list for this computer:
echo "pixman-0.32.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################