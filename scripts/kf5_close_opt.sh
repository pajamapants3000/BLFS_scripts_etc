#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kf5_close_opt /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
as_root mv /opt/kf5{,-5.12.0}
as_root ln -sfv kf5-5.12.0 /opt/kf5
#
as_root sed -i "s/\(^Exec=.*startkde\)/\1-wrapper/" \
    /usr/share/xsessions/plasma.desktop
as_root install -Dm755 -v -o root -g root files/usr/bin/plasma-wrapper \
    $KF5_PREFIX/bin/startkde-wrapper
#
# Add to installed list for this computer:
echo "kf5_close_opt" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

