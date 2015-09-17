#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gpgme-1.6.0
#
# Dependencies
#**************
# Begin Required
#libassuan-2.3.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gnupg-2.1.7
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gpgme-1.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-1.6.0.tar.bz2
# md5sum:
echo "60d730d22e8065fd5de309e8b98e304b gpgme-1.6.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gpgme-1.6.0.tar.bz2
cd gpgme-1.6.0
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gpgme-1.6.0
#
# Add to installed list for this computer:
echo "gpgme-1.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
