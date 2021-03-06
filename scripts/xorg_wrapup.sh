#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Deletes all files copied from Xorg subfolder (leaves originals alone!)
#
# Dependencies
#**************
# Begin Required
#x_window_system
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
grep xorg_wrapup /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
for file in $(ls Xorg)
do
    rm -v $file
done
as_root install -dm755 -o root -g root /etc/X11/app-defaults/xinitrc.d
for file in $(ls -A files/etc/X11/app-defaults/xinitrc.d); do
    install -v -o root -g root -Dm755 \
        files/etc/X11/app-defaults/xinitrc.d/${file} /etc/X11/app-defaults/xinitrc.d
done
# Add to installed list for this computer:
echo "xorg_wrapup" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
