#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/21/2015
#
# Check for previous installation:
PROCEED="yes"
grep dos2unix-7.2.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/dos2unix/files/dos2unix/7.2.3/dos2unix-7.2.3.tar.gz
#
tar -xvf dos2unix-7.2.3.tar.gz
cd dos2unix-7.2.3
make
#
as_root make install
cd ..
as_root rm -rf dos2unix-7.2.3
#
# Add to installed list for this computer:
echo "dos2unix-7.2.3" >> /list-$CHRISTENED"-"$SURNAME
# Installed:
# dos2unix
#
###################################################