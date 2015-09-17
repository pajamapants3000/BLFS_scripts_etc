#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libksba-1.3.3
#
# Dependencies
#**************
# Begin Required
#libgpg_error-1.20
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
grep libksba-1.3.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.3.tar.bz2
# md5sum:
echo "a5dd3c57fca254935f5cf8db26e39065 libksba-1.3.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libksba-1.3.3.tar.bz2
cd libksba-1.3.3
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libksba-1.3.3
#
# Add to installed list for this computer:
echo "libksba-1.3.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################