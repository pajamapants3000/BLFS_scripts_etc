#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for emotion_generic_players-1.15.0
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
grep "emotion_generic_players-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/libs/emotion_generic_players/emotion_generic_players-1.15.0.tar.gz
# md5sum:
#echo "XXX emotion_generic_players-1.15.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf emotion_generic_players-1.15.0.tar.gz
cd emotion_generic_players-1.15.0
./configure --prefix=$ENL_PREFIX
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
#
as_root ldconfig
#
cd ..
as_root rm -rf emotion_generic_players-1.15.0
#
# Add to installed list for this computer:
echo "emotion_generic_players-1.15.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
