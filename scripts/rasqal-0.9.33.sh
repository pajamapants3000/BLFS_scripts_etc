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
#raptor-2.0.15
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pcre-8.37
#libgcrypt-1.6.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep rasqal-0.9.33 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.librdf.org/source/rasqal-0.9.33.tar.gz
# md5sum:
echo "1f5def51ca0026cd192958ef07228b52 rasqal-0.9.33.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf rasqal-0.9.33.tar.gz
cd rasqal-0.9.33
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf rasqal-0.9.33
#
# Add to installed list for this computer:
echo "rasqal-0.9.33" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################