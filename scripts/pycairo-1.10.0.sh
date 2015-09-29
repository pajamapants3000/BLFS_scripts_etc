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
#cairo-1.14.0
#python-3.4.2
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
grep pycairo-1.10.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cairographics.org/releases/pycairo-1.10.0.tar.bz2
# md5sum:
echo "e6fd3f2f1e6a72e0db0868c4985669c5 pycairo-1.10.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patches
wget http://www.linuxfromscratch.org/patches/blfs/7.7/pycairo-1.10.0-waf_unpack-1.patch
wget http://www.linuxfromscratch.org/patches/blfs/7.7/pycairo-1.10.0-waf_python_3_4-1.patch
tar -xvf pycairo-1.10.0.tar.bz2
cd pycairo-1.10.0
patch -Np1 -i ../pycairo-1.10.0-waf_unpack-1.patch
wafdir=$(./waf unpack)
pushd $wafdir
patch -Np1 -i ../../pycairo-1.10.0-waf_python_3_4-1.patch
popd
unset wafdir
PYTHON=/usr/bin/python3 ./waf configure --prefix=/usr
./waf build
#
as_root ./waf install
cd ..
as_root rm -rf pycairo-1.10.0
#
# Add to installed list for this computer:
echo "pycairo-1.10.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################