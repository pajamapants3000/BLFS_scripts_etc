#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Check for previous installation:
PROCEED="yes"
grep confuse-2.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://savannah.nongnu.org/download/confuse/confuse-2.7.tar.gz
#
tar -xvf confuse-2.7.tar.gz
cd confuse-2.7
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf confuse-2.7
#
# Add to installed list for this computer:
echo "confuse-2.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################