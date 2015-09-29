#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source enlightenment.sh
#
source blfs_profile
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
grep "enventor-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/apps/enventor/enventor-0.6.0.tar.gz
# md5sum:
#echo "XXX enventor-0.6.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf enventor-0.6.0.tar.gz
cd enventor-0.6.0
./configure --prefix=$ENL_PREFIX
make
#
as_root make install
#
as_root ldconfig
#
cd ..
as_root rm -rf enventor-0.6.0
#
# Add to installed list for this computer:
echo "enventor-0.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
