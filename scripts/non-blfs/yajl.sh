#!/bin/bash -ev
# Installation script for yajl
# Requirements: Ruby and CMake
# Check for previous installation:
PROCEED="yes"
grep yajl /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
pushd ~/git_repos
git clone -b 2.1.0 git://github.com/lloyd/yajl yajl
cd yajl
./configure --prefix=/usr
as_root make install
popd
as_root rm -rf ~/git_repos/yajl
# Installed flawlessly!
# Add to list of installed programs on this system
echo "yajl" >> /list-$CHRISTENED"-"$SURNAME
#