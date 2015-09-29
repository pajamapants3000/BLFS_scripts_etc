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
#libsigc++-2.4.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#boost-1.57.0
#doxygen-1.8.9.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep cairomm-1.10.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cairographics.org/releases/cairomm-1.10.0.tar.gz
# md5sum:
echo "9c63fb1c04c8ecd3c5e6473075b8c39f cairomm-1.10.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf cairomm-1.10.0.tar.gz
cd cairomm-1.10.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf cairomm-1.10.0
#
# Add to installed list for this computer:
echo "cairomm-1.10.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################