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
grep chmlib-0.40 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.jedrea.com/chmlib/chmlib-0.40.tar.gz
#
tar -xvf chmlib-0.40.tar.gz
cd chmlib-0.40
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf chmlib-0.40
#
# Add to installed list for this computer:
echo "chmlib-0.40" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
