#!/bin/bash -ev
# Installation script for qtile-dev
# Obtains latest development version (currently 0.9.0) from main git branch
#
# Dependencies
#**************
# Begin Required
#Xorg
#python-3.4.2
#python-mods
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
grep qtile-dev /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Installs/works with python3
pushd ~/git_repos
# This is the development release!
git clone git://github.com/qtile/qtile.git qtile
cd qtile
as_root python3 setup.py install
mkdir -pv ~/.config/qtile
[ -d /usr/share/xsessions ] || as_root mkdir /usr/share/xsessions
cp -v libqtile/resources/default_config.py ~/.config/qtile/
cp -nv ~/.config/qtile/default_config.py ~/.config/qtile/config.py
as_root cp -v resources/qtile.desktop /usr/share/xsessions/
popd
as_root rm -rf ~/git_repos/qtile
# Add to list of installed programs on this system
echo "qtile-dev" >> /list-$CHRISTENED"-"$SURNAME
#
