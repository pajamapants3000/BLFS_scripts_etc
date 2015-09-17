#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for enlightenment-0.19.8
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
grep "enlightenment-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.19.8.tar.gz
# md5sum:
#echo "XXX enlightenment-0.19.8.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf enlightenment-0.19.8.tar.gz
cd enlightenment-0.19.8
./configure --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf enlightenment-0.19.8
#
# Add to installed list for this computer:
echo "enlightenment-0.19.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
