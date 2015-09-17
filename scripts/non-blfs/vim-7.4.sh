#!/bin/bash -ev
# Beyond Linux From Scratch 7.6
# Installation script for vim-7.4
#
# Required: Under Ubuntu using apt:
#   libncurses5-dev, libgnome2-dev, libgnomeui-dev, libgtk2.0-dev, libatk1.0-dev, libbonoboui2-dev, libcairo2-dev
#   libx11-dev libxpm-dev libxt-dev
# These are required to build gui, extrapolate from that...?
#
# Check for previous installation:
PROCEED="yes"
grep "^vim-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
hg clone https://vim.googlecode.com/hg/ vim
pushd vim
patch -p1 < ../vim_patch.diff
cd src
make
#
as_root make install
popd; as_root rm -rf vim
#
# Add to installed list for this computer:
echo "vim-7.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

