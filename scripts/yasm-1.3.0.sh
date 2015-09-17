#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for yasm-1.3.0
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#python-2.7.9
#python-3.4.2
#cython
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep yasm-1.3.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
# md5sum:
echo "fc9e586751ff789b34b1f21d572d96af yasm-1.3.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
sed -i 's#) ytasm.*#)#' Makefile.in
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf yasm-1.3.0
#
# Add to installed list for this computer:
echo "yasm-1.3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################