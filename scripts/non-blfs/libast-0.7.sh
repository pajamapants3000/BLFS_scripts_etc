#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
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
grep "libast-0.7" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://freecode.com/urls/ef47a227a6b7f73a065d876996d37f78 \
    -O libast-0.7.tar.gz
# md5sum:
echo "a9ec3b2da317f35869316e6d9571d296 libast-0.7.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libast-0.7.tar.gz
cd libast-0.7
./configure --prefix=/usr
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
cd ..
as_root rm -rf libast-0.7
#
# Add to installed list for this computer:
echo "libast-0.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

