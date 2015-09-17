#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for icu-55.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#llvm-3.6.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep icu-55.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-src.tgz
# md5sum:
echo "e2d523df79d6cb7855c2fbe284f4db29 icu4c-55_1-src.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf icu4c-55_1-src.tgz
cd icu
cd source
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ../..
as_root rm -rf icu
#
# Add to installed list for this computer:
echo "icu-55.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
