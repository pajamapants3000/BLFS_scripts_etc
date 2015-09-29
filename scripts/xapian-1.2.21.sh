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
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xapian_core-1.2.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://oligarchy.co.uk/xapian/1.2.21/xapian-core-1.2.21.tar.xz
# md5sum:
echo "276497a458a8ae63e7dceb372cc1bc37 xapian-core-1.2.21.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xapian-core-1.2.21.tar.xz
cd xapian-core-1.2.21
./configure --prefix=/usr --disable-static             \
            --docdir=/usr/share/doc/xapian-core-1.2.21
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf xapian-core-1.2.21
#
# Add to installed list for this computer:
echo "xapian_core-1.2.21" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################