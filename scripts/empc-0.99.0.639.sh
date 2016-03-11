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
grep "empc-0.99.0.639" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://download.enlightenment.org/rel/apps/empc/empc-0.99.0.639.tar.gz
# md5sum:
#echo "XXX empc-0.99.0.639.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf empc-0.99.0.639.tar.gz
cd empc-0.99.0.639
./configure --prefix=$ENL_PREFIX
make
#
as_root make install
#
as_root ldconfig
#
cd ..
as_root rm -rf empc-0.99.0.639
#
# Add to installed list for this computer:
echo "empc-0.99.0.639" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
