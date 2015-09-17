#!/bin/bash -ev
# Installation script for XXX
###########################################
# Required: (*** were missing, installed separately without issue.)
#* Main XCB libraries:
# - xcb-proto (>= 1.6)
# - libxcb (>= 1.8)
# - libxcb-composite
# - libxcb-xfixes
# - libxcb-damage
# - libxcb-image
# - libxcb-render
# - libxcb-randr
#* xcb-util libraries:
# - libxcb-aux
# - libxcb-keysyms
# - libxcb-event
# - libxcb-ewmh
# - libxcb-renderutil
#* Other libraries and tools:
# - x11proto-core
#*** libconfuse
#*** libev
#*** libxdg-basedir (>= 1.0.0)
# - pkg-config
#*** xkbcommon
############################################
# Check for previous installation:
PROCEED="yes"
grep unagi-0.3.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://projects.mini-dweeb.org/attachments/download/114/unagi-0.3.4.tar.gz
#
tar -xvf unagi-0.3.4.tar.gz
cd unagi-0.3.4
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf unagi-0.3.4
cp -v /usr/etc/xdg/unagi.conf ~/.config/
#########################################
#
# git version fails, but this works great!
#
#########################################
# Add to list of installed programs on this system
echo "unagi-0.3.4" >> /list-$CHRISTENED"-"$SURNAME
#