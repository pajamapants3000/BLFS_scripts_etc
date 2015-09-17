#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for enventor-git
#
source enlightenment.sh
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#efl-1.15.0
#elementary-1.15.0
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
# Clone repository:
git clone http://git.enlightenment.org/tools/enventor.git
#
cd enventor
./autogen.sh --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf enventor
#
# Add to installed list for this computer:
echo "enventor-git" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
