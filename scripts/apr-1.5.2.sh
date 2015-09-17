#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for apr-1.5.2
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
grep apr-1.5.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.apache.org/dist/apr/apr-1.5.2.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.mirrorservice.org/sites/ftp.apache.org/apr/apr-1.5.2.tar.bz2
#
# md5sum:
echo "4e9769f3349fe11fc0a5e1b224c236aa apr-1.5.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf apr-1.5.2.tar.bz2
cd apr-1.5.2
./configure --prefix=/usr    \
            --disable-static \
            --with-installbuilddir=/usr/share/apr-1/build
make
# Test:
make test
#
as_root make install
cd ..
as_root rm -rf apr-1.5.2
#
# Add to installed list for this computer:
echo "apr-1.5.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################