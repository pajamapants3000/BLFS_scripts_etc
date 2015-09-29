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
#libxml2-2.9.2
#lzo-2.09
#nettle-3.1.1
#openssl-1.0.2d
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libarchive-3.1.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.libarchive.org/downloads/libarchive-3.1.2.tar.gz
# md5sum:
echo "efad5a503f66329bb9d2f4308b5de98a libarchive-3.1.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libarchive-3.1.2.tar.gz
cd libarchive-3.1.2
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libarchive-3.1.2
#
# Add to installed list for this computer:
echo "libarchive-3.1.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################