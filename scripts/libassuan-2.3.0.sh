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
#libgpg_error-1.20
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libassuan-2.3.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.3.0.tar.bz2
# md5sum:
echo "d3effa069a3ccf924c8ed8a6d46cbc8d libassuan-2.3.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libassuan-2.3.0.tar.bz2
cd libassuan-2.3.0
./configure --prefix=/usr
make
# with texlive - alt docs
#make -C doc pdf ps
# Test:
make check
#
as_root make install
# texlive - alt docs install
#as_root install -v -dm755 /usr/share/doc/libassuan-2.3.0
#as_root install -v -m644  doc/assuan.{pdf,ps,dvi} \
#                  /usr/share/doc/libassuan-2.3.0
cd ..
as_root rm -rf libassuan-2.3.0
#
# Add to installed list for this computer:
echo "libassuan-2.3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
