#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
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
grep media_player_info-22 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/media-player-info/media-player-info-22.tar.gz
#
tar -xvf media-player-info-22.tar.gz
cd media-player-info-22
./configure
make
#
as_root make install
cd ..
as_root rm -rf media-player-info-22
#
# Add to installed list for this computer:
echo "media_player_info-22" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################