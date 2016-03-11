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
grep "efl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/libs/efl/efl-1.15.0.tar.gz
# md5sum:
#echo "XXX efl-1.15.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf efl-1.15.0.tar.gz
cd efl-1.15.0
if (cat /list-${CHRISTENED}-${SURNAME} | grep xine_lib > /dev/null); then
./configure --prefix=$ENL_PREFIX --enable-xine
else
./configure --prefix=$ENL_PREFIX
fi
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf efl-1.15.0
#
# Add to installed list for this computer:
echo "efl-1.15.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
