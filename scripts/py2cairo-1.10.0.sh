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
#python-2.7.9
#cairo-1.14.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pytest
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep py2cairo-1.10.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2
# md5sum:
echo "20337132c4ab06c1146ad384d55372c5 py2cairo-1.10.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf py2cairo-1.10.0.tar.bz2
cd py2cairo-1.10.0
./waf configure --prefix=/usr
./waf build
#
as_root ./waf install
cd ..
as_root rm -rf py2cairo-1.10.0
#
# Add to installed list for this computer:
echo "py2cairo-1.10.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################