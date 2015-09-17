#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lzo-2.09
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
grep lzo-2.09 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.09.tar.gz
# md5sum:
echo "c7ffc9a103afe2d1bba0b015e7aa887f lzo-2.09.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lzo-2.09.tar.gz
cd lzo-2.09
./configure --prefix=/usr                    \
            --enable-shared                  \
            --disable-static                 \
            --docdir=/usr/share/doc/lzo-2.09
make
# Test:
make check
# Full suite:
make test
#
as_root make install
cd ..
as_root rm -rf lzo-2.09
#
# Add to installed list for this computer:
echo "lzo-2.09" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################