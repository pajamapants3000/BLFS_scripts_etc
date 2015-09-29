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
grep "sg3_utils-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sg.danny.cz/sg/p/sg3_utils-1.41.tar.xz
# md5sum:
echo "79c8e3c0b2e4bad7dcba3e1ab090f3b4 sg3_utils-1.41.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf sg3_utils-1.41.tar.gz
cd sg3_utils-1.41
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf sg3_utils-1.41
#
# Add to installed list for this computer:
echo "sg3_utils-1.41" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
