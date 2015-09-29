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
grep npth-1.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/npth/npth-1.2.tar.bz2
# md5sum:
echo "226bac7374b9466c6ec26b1c34dab844 npth-1.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf npth-1.2.tar.bz2
cd npth-1.2
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf npth-1.2
#
# Add to installed list for this computer:
echo "npth-1.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################