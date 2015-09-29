#!/bin/bash -ev
#
# Installation Script
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
grep "enl_close_opt" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
rm enlightenment.sh
install -Dm755 -o $USER -g $USER files/.xinitrc-enl $HOME/
sed -i "s/^#\( *enl\)/\1/" $HOME/.xinitrc
#
echo "Enlightenment has been installed!"
echo "Run setenl, exit any running X-window session, then run"
echo "startx $HOME/.xinitrc-enl"
echo "or"
echo "xinit enl"
#
# Add to installed list for this computer:
echo "enl_close_opt" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


