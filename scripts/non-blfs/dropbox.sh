#!/bin/bash -ev
# Installation script for dropbox daemon
# Required: python 2, X, pygtk
# # IMPORTANT! Make sure D-Bus is all set up, along with
#   dbus-python.
# Haven't tried running this script yet, but it might work.
#   Will get a GUI pop out (floating) then a new window.
# Check for previous installation:
PROCEED="yes"
grep dropbox /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://linux.dropbox.com/packages/dropbox.py
#
/usr/bin/python2 dropbox.py start -i
#
# Add to list of installed programs on this system
echo "dropbox" >> /list-$CHRISTENED"-"$SURNAME
#