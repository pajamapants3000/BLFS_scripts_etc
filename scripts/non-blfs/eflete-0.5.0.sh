#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for eflete-0.5.0
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
grep "eflete-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/apps/eflete/eflete-0.5.0.tar.gz
# md5sum:
#echo "XXX eflete-0.5.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf eflete-0.5.0.tar.gz
cd eflete-0.5.0
./configure --prefix=$ENL_PREFIX
make
#
as_root make install
#
as_root ldconfig
#
cd ..
as_root rm -rf eflete-0.5.0
#
# Add to installed list for this computer:
echo "eflete-0.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
