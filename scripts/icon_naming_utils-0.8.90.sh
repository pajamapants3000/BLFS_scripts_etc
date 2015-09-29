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
#xml__simple-2.20
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
grep icon_naming_utils-0.8.90 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://tango.freedesktop.org/releases/icon-naming-utils-0.8.90.tar.bz2
#
# md5sum:
echo "dd8108b56130b9eedc4042df634efa66 icon-naming-utils-0.8.90.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf icon-naming-utils-0.8.90.tar.bz2
cd icon-naming-utils-0.8.90
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf icon-naming-utils-0.8.90
#
# Add to installed list for this computer:
echo "icon_naming_utils-0.8.90" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################