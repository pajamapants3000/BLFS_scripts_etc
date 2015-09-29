#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
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
grep hunspell-1.3.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/hunspell/files/Hunspell/1.3.3/hunspell-1.3.3.tar.gz
# md5sum:
echo "4967da60b23413604c9e563beacc63b4 hunspell-1.3.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf hunspell-1.3.3.tar.gz
cd hunspell-1.3.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf hunspell-1.3.3
#
# Add to installed list for this computer:
echo "hunspell-1.3.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################