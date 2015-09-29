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
#gtk+-2.24.28
#libcap-2.24
#libsecret-0.18.3
#qt-4.8.7
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pinentry-0.9.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/pinentry/pinentry-0.9.5.tar.bz2
# md5sum:
echo "55439c4436b59573a29e144916ee5b61 pinentry-0.9.5.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pinentry-0.9.5.tar.bz2
cd pinentry-0.9.5
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf pinentry-0.9.5
#
# Add to installed list for this computer:
echo "pinentry-0.9.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################