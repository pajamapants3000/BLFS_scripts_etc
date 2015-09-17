#!/bin/bash -ev
# Installation script for xpyb-ng
# Time: 0.7 SBU
# Check for previous installation:
PROCEED="yes"
grep xpyb-ng /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Git-Download:
# https://github.com/dequis/xpyb-ng.git
pushd ~/git_repos
git clone -b pre-1.7.1-xproto https://github.com/tych0/xpyb-ng.git xpyb-ng
cd xpyb-ng
as_root python setup.py install
popd
as_root rm -rf ~/git_repos/xpyb-ng
# Poor results with this, use non-ng version
# Add to list of installed programs on this system
echo "xpyb-ng" >> /list-$CHRISTENED"-"$SURNAME
#