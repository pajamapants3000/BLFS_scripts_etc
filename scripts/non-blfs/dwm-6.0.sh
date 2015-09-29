#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Requirements: Xlib header files
# Check for previous installation:
PROCEED="yes"
grep dwm-6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dl.suckless.org/dwm/dwm-6.0.tar.gz
#
tar -xvf dwm-6.0.tar.gz
cd dwm-6.0
# Use sed to make any desired changes to config.mk. To change prefix to /usr
sed -i 's_usr/local_usr_' config.mk
# Though I may later decide to put this in local; something to consider...
as_root make clean install
cd ..
as_root rm -rf dwm-6.0
# Add to list of installed programs on this system
echo "dwm-6.0" >> /list-$CHRISTENED"-"$SURNAME
#