#!/bin/bash -ev
# Installation script for tabbed-0.6
# Requirements: ??
# Check for previous installation:
PROCEED="yes"
grep tabbed-0.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dl.suckless.org/tools/tabbed-0.6.tar.gz
#
tar -xvf tabbed-0.6.tar.gz
cd tabbed-0.6
# Use sed to make any desired changes to config.mk. To change prefix to /usr
sed -i 's_usr/local_usr_' config.mk
# Though I may later decide to put this in local; something to consider...
as_root make clean install
cd ..
as_root rm -rf dwm-6.0
# Add to list of installed programs on this system
echo "tabbed-0.6" >> /list-$CHRISTENED"-"$SURNAME
#