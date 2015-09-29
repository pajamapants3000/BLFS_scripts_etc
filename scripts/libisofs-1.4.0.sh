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
grep libisofs-1.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://files.libburnia-project.org/releases/libisofs-1.4.0.tar.gz
#
# md5sum:
echo "394f9025d40b5f9b1b884a72bfaf5bed libisofs-1.4.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libisofs-1.4.0.tar.gz
cd libisofs-1.4.0
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libisofs-1.4.0
#
# Add to installed list for this computer:
echo "libisofs-1.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################