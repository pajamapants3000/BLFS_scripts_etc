#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libconfig-1.5
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
grep "libconfig-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.hyperrealm.com/libconfig/libconfig-1.5.tar.gz
#
tar -xvf libconfig-1.5.tar.gz
cd libconfig-1.5
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf libconfig-1.5
#
# Add to installed list for this computer:
echo "libconfig-1.5" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#