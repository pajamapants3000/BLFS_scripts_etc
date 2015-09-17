#!/bin/bash -ev
# Installation script for yajl-2.1.0
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#ruby-2.2.3
#cmake-3.3.1
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
grep yajl-2.1.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://github.com/lloyd/yajl/tarball/2.1.0/yajl-2.1.0.tar.gz
#
tar -xvf yajl-2.1.0.tar.gz
cd lloyd-yajl-66cb08c
./configure --prefix=/usr
#
as_root make install
cd ..
as_root rm -rf lloyd-yajl-66cb08c
#
# Add to installed list for this computer:
echo "yajl-2.1.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
