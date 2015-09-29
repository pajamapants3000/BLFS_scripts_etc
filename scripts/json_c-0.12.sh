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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep json_c-0.12 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.tar.gz
# md5sum:
echo "3ca4bbb881dfc4017e8021b5e0a8c491 json-c-0.12.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf json-c-0.12.tar.gz
cd json-c-0.12
sed -i s/-Werror// Makefile.in
./configure --prefix=/usr --disable-static
make -j1
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf json-c-0.12
#
# Add to installed list for this computer:
echo "json_c-0.12" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################