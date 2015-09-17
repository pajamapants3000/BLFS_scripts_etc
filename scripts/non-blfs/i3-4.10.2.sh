#!/bin/bash -ev
# Installation script for i3-4.10.2
# Updated 07/19/2015
#
# Dependencies: See separate i3.DEPENDS file, or DEPENDS in root folder of
#   package.
#
# Default prefix is /usr
#
# Check for previous installation:
PROCEED="yes"
grep i3-4.10.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://i3wm.org/downloads/i3-4.10.2.tar.bz2
# md5sum:
#
##
tar -xvf i3-4.10.2.tar.bz2
cd i3-4.10.2
patch -p1 < ../patches/i3-4.10.2-patch.diff
as_root make clean install
[ -d ~/.config/i3 ] || mkdir -pv ~/.config/i3
[ -f ~/.config/i3/config ] && cp ~/.config/i3/config ~/.config/i3/config.old || ((1))
cp -v i3.config ~/.config/i3/config
cd ..
as_root rm -rf i3-4.10.2
# Add to list of installed programs on this system
echo "i3-4.10.2" >> /list-$CHRISTENED"-"$SURNAME
#
# May want to go back and edit source before installing.
#
# Install i3status for optimal performance (plus no errors!)
#
########################################################