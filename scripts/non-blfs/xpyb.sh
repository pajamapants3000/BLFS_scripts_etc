#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Check for previous installation:
PROCEED="yes"
grep xpyb /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
pushd ~/git_repos
git clone git://anongit.freedesktop.org/xcb/xpyb
cd xpyb && ./autogen.sh --prefix=/usr
./configure --prefix=/usr
as_root make install
popd
as_root rm -rf ~/git_repos/xpyb
# Add to list of installed programs on this system
echo "xpyb" >> /list-$CHRISTENED"-"$SURNAME
#