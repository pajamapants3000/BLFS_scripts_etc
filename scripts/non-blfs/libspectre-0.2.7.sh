#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#ghostscript-9.16
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
grep libspectre-0.2.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://libspectre.freedesktop.org/releases/libspectre-0.2.7.tar.gz
# sha1sum (not sure why this isn't working!):
#echo "a7efd97b82b84ff1bb7a0d88c7e35ad10cc84ea8  libspectre-0.2.7.tar.gz" | shasum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libspectre-0.2.7.tar.gz
cd libspectre-0.2.7
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libspectre-0.2.7
#
# Add to installed list for this computer:
echo "libspectre-0.2.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################