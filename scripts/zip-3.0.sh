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
grep "^zip-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/infozip/zip30.tar.gz
# FTP/alt Download:
#wget ftp://ftp.info-zip.org/pub/infozip/src/zip30.tgz
#
# md5sum:
echo "7b74551e63f8ee6aab6fbc86676c0d37 zip30.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf zip30.tar.gz
cd zip30
make -f unix/Makefile generic_gcc
#
as_root make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install
cd ..
as_root rm -rf zip30
#
# Add to installed list for this computer:
echo "zip-3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
