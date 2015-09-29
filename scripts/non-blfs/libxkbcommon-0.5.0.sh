#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Check for previous installation:
PROCEED="yes"
grep libxkbcommon-0.5.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xkbcommon.org/download/libxkbcommon-0.5.0.tar.xz
# md5sum:
echo "2e1faeafcc609c30af3a561a91e84158 libxkbcommon-0.5.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxkbcommon-0.5.0.tar.xz
cd libxkbcommon-0.5.0
./configure --prefix=/usr
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libxkbcommon-0.5.0
#
# Add to installed list for this computer:
echo "libxkbcommon-0.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################