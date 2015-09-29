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
grep libgpg_error-1.20 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.19.tar.bz2
# md5sum:
echo "c04c16245b92829281f43b5bef7d16da libgpg-error-1.19.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libgpg-error-1.19.tar.bz2
cd libgpg-error-1.19
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
as_root install -v -m644 -D README /usr/share/doc/libgpg-error-1.19/README
cd ..
as_root rm -rf libgpg-error-1.19
#
# Add to installed list for this computer:
echo "libgpg_error-1.20" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################