#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for alarm-git
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
grep "alarm-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
git clone http://git.enlightenment.org/enlightenment/modules/alarm.git alarm
cd alarm
./configure --prefix=$ENL_PREFIX
make
#
as_root make install
#
as_root ldconfig
#
cd ..
as_root rm -rf alarm
#
# Add to installed list for this computer:
echo "alarm-git" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
