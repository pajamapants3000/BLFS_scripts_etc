#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for empc-git
#
source enlightenment.sh
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#libmpdclient-2.9
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
grep "empc-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Clone repository:
git clone http://git.enlightenment.org/apps/empc.git
#
cd empc
./autogen.sh
./configure --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf empc
#
# Add to installed list for this computer:
echo "empc-git" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
