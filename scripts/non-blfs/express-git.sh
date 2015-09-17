#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for express-git
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
grep "express-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
git clone http://git.enlightenment.org/apps/express.git express
cd express
./autogen.sh --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf express
#
# Add to installed list for this computer:
echo "express-git" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
