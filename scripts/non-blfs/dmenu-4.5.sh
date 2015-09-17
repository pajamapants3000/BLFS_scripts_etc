#!/bin/bash -ev
# Installation script for dmenu
# Requirements: Xlib header files
# Check for previous installation:
PROCEED="yes"
grep dmenu-4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dl.suckless.org/tools/dmenu-4.5.tar.gz
#
tar -xvf dmenu-4.5.tar.gz
cd dmenu-4.5
# Use sed to make any desired changes to config.mk. To change prefix to /usr
sed -i 's_usr/local_usr_' config.mk
# Though I may later decide to put this in local; something to consider...
as_root make clean install
cd ..
as_root rm -rf dmenu-4.5
# Add to list of installed programs on this system
echo "dmenu-4.5" >> /list-$CHRISTENED"-"$SURNAME
#