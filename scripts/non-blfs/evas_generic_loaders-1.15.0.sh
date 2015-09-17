#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for evas_generic_loaders-1.15.0
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
grep "evas_generic_loaders-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/libs/evas_generic_loaders/evas_generic_loaders-1.15.0.tar.gz
# md5sum:
#echo "XXX evas_generic_loaders-1.15.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf evas_generic_loaders-1.15.0.tar.gz
cd evas_generic_loaders-1.15.0
./configure --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf evas_generic_loaders-1.15.0
#
# Add to installed list for this computer:
echo "evas_generic_loaders-1.15.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
