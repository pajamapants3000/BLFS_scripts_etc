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
#libexif-0.6.21
#libxfce4ui-4.12.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#tumbler-0.1.31
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ristretto-0.8.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/ristretto/0.8/ristretto-0.8.0.tar.bz2
#
# md5sum:
echo "94c778850325a4e5a12e3433c8a05432 ristretto-0.8.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ristretto-0.8.0.tar.bz2
cd ristretto-0.8.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf ristretto-0.8.0
#
# Add to installed list for this computer:
echo "ristretto-0.8.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################