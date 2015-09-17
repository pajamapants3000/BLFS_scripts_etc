#!/bin/bash -ev
# Installation script for smplayer-14.9.0
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#qt-5.5.0
##qt-4.8.7
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
grep smplayer-14.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/smplayer/files/SMPlayer/14.9.0/smplayer-14.9.0.tar.bz2
# md5sum:
echo "34bd6762f684064bafdaea0afa4e2d40 smplayer-14.9.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf smplayer-14.9.0.tar.bz2
cd smplayer-14.9.0
make PREFIX=/usr
#
as_root make PREFIX=/usr install
cd ..
as_root rm -rf smplayer-14.9.0
#
# Add to installed list for this computer:
echo "smplayer-14.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
