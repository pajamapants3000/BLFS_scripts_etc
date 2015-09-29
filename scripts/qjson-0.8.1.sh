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
#qt-4.8.7
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
grep qjson-0.8.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/qjson/qjson-0.8.1.tar.bz2
# md5sum:
echo "323fbac54a5a20c0b8fe45c1ced03e2d qjson-0.8.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qjson-0.8.1.tar.bz2
cd qjson-0.8.1
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release ..
make
#
as_root make install
cd ../..
as_root rm -rf qjson-0.8.1
#
# Add to installed list for this computer:
echo "qjson-0.8.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################