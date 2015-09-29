#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Obtains latest development version (currently 0.10.1) from main git branch
#
# Dependencies
#**************
# Begin Required
#Xorg
#python-3.4.2
#pycairo-1.10.0 (with python_mods, specifically xcffib, as dep)
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
grep "qtile-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
as_root pip3 install qtile
mkdir -pv ~/.config/qtile
[ -d /usr/share/xsessions ] || as_root mkdir /usr/share/xsessions
install -Dm644 -o $USER -g $USER \
    /usr/lib/python3.4/site-packages/libqtile/resources/default_config.py \
    ~/.config/qtile/default_config.py
cp -nv ~/.config/qtile/default_config.py ~/.config/qtile/config.py
as_root install -Dm644 -o root -g root \
    files/qtile.desktop /usr/share/xsessions/qtile.desktop
#
# Add to list of installed programs on this system
echo "qtile-pip" >> /list-$CHRISTENED"-"$SURNAME
#
