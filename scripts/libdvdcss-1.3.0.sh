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
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libdvdcss-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.videolan.org/libdvdcss/1.3.0/libdvdcss-1.3.0.tar.bz2
# md5sum:
echo "7f0fdb3ff91d638f5e45ed7536f7eb67 libdvdcss-1.3.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdvdcss-1.3.0.tar.bz2
cd libdvdcss-1.3.0
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdcss-1.3.0
make
#
as_root make install
cd ..
as_root rm -rf libdvdcss-1.3.0
#
# Add to installed list for this computer:
echo "libdvdcss-1.3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

