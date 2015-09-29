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
#libjpeg_turbo-1.4.1
#jasper-1.900.1
#little_cms-2.7
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
grep "libraw-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.libraw.org/data/LibRaw-0.17.0.tar.gz
# md5sum:
echo "f6d2b9dd22e63ac0f0bd3944489a81c6 LibRaw-0.17.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf LibRaw-0.17.0.tar.gz
cd LibRaw-0.17.0
./configure --prefix=/usr    \
            --enable-jpeg    \
            --enable-jasper  \
            --enable-lcms    \
            --disable-static \
            --docdir=/usr/share/doc/libraw-0.17.0
make
#
as_root make install
cd ..
as_root rm -rf LibRaw-0.17.0
#
# Add to installed list for this computer:
echo "libraw-0.17.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
