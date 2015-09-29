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
#python2.7.10
#tk-8.6.4
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
grep imaging-1.1.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz
#
# Required patch download
wget http://www.linuxfromscratch.org/patches/downloads/Imaging/Imaging-1.1.7-freetype_fix-1.patch
tar -xvf Imaging-1.1.7.tar.gz
cd Imaging-1.1.7
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf Imaging-1.1.7
#
# Add to installed list for this computer:
echo "imaging-1.1.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################