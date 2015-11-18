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
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep popt-1.16 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://rpm5.org/files/popt/popt-1.16.tar.gz
# FTP/alt Download:
#wget ftp://anduin.linuxfromscratch.org/BLFS/svn/p/popt-1.16.tar.gz
#
# md5sum:
echo "3743beefa3dd6247a73f8f7a32c14c33 popt-1.16.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf popt-1.16.tar.gz
cd popt-1.16
./configure --prefix=/usr
make
# with doxygen
#doxygen
#
# Test:
#make check
#
as_root make install
# with doxygen
#as_root install -v -m755 -d /usr/share/doc/popt-1.16
#as_root install -v -m644 doxygen/html/* /usr/share/doc/popt-1.16
#
cd ..
as_root rm -rf popt-1.16
#
# Add to installed list for this computer:
echo "popt-1.16" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
