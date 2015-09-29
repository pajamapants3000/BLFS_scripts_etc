#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Check for previous installation:
PROCEED="yes"
grep "flash_player_11-firefox" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
# Package can be obtained from http://get.adobe.com/flashplayer/
# Select .tar.gz from the dropdown box.
# Or for automated download:
# Download:
wget ftp://www.daba.lv/pub/MultiVide/MacroMedia/x64/install_flash_player_11_linux.x86_64.tar.gz
#
tar -xvf install_flash_player_11_linux.x86_64.tar.gz
as_root mkdir -pv /usr/lib/kde4
as_root cp -v usr/lib64/kde4/kcm_adobe_flash_player.so /usr/lib/kde4/
rm -rf usr/lib*
as_root cp -vr usr/* /usr/
as_root cp libflashplayer.so /usr/lib/mozilla/plugins/
#
# Clean up:
rm -rf usr
rm libflashplayer.so
#
# Add to installed list for this computer:
echo "flash_player_11-firefox" >> /list-$CHRISTENED"-"$SURNAME
###################################################
