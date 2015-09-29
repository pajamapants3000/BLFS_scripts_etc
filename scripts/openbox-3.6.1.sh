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
#x_window_system
#pango-1.36.8
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dbus-1.10.0
#imlib2-1.4.7
#pyxdg-0.25
#startup_notification-0.12
#librsvg-2.40.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep openbox-3.6.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://openbox.org/dist/openbox/openbox-3.6.1.tar.gz
#
# md5sum:
echo "b72794996c6a3ad94634727b95f9d204 openbox-3.6.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf openbox-3.6.1.tar.gz
cd openbox-3.6.1
# Python3-ify it
2to3 -w data/autostart/openbox-xdg-autostart
sed 's/python/python3/' -i data/autostart/openbox-xdg-autostart
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  \
            --docdir=/usr/share/doc/openbox-3.6.1
make
#
as_root make install
cd ..
as_root rm -rf openbox-3.6.1
#
# Add to installed list for this computer:
echo "openbox-3.6.1" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#
# Copy system menu config to home to customize
cp -rf /etc/xdg/openbox ~/.config/
#
# Here is a default .xinitrc for openbox that uses dbus and numlockx,
#+and dislays a random background image from the folder ~/.config/backgrounds
install -Dm755 -o $USER -g $USER files/.xinitrc-openbox $HOME/
#
#################################################
