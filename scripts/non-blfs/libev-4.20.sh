#!/bin/bash -ev
# Installation script for libev-4.20
# Updated 07/19/2015
#
# Check for previous installation:
PROCEED="yes"
grep libev-4.20 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dist.schmorp.de/libev/libev-4.20.tar.gz
tar -xvf libev-4.20.tar.gz
cd libev-4.20
./configure --prefix=/usr
make
as_root make install
cd ..
as_root rm -rf libev-4.20
# Add to list of installed programs on this system
echo "libev-4.20" >> /list-$CHRISTENED"-"$SURNAME
#