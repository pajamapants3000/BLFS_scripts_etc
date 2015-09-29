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
#boost-1.57.0
#llvm-3.5.1
#gdb-7.9
#openmp
#libxslt-1.1.28
#texlive-20140525
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep valgrind-3.10.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://valgrind.org/downloads/valgrind-3.10.1.tar.bz2
# Required patch download:
wget http://www.linuxfromscratch.org/patches/blfs/7.7/valgrind-3.10.1-glibc_2.21-1.patch
#
# md5sum:
echo "60ddae962bc79e7c95cfc4667245707f valgrind-3.10.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf valgrind-3.10.1.tar.bz2
cd valgrind-3.10.1
patch -Np1 -i ../valgrind-3.10.1-glibc_2.21-1.patch
sed -i 's/-mt//g' configure
sed -i 's|/doc/valgrind||' docs/Makefile.in
./configure --prefix=/usr \
            --datadir=/usr/share/doc/valgrind-3.10.1
make
# Test - may hang without gdb
#make regtest
#
as_root make install
cd ..
as_root rm -rf valgrind-3.10.1
#
# Add to installed list for this computer:
echo "valgrind-3.10.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################