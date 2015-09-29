#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Required: Python-2.7.8 and Cairo-1.12.16, xpyb
# Check for previous installation:
PROCEED="yes"
grep Py2cairo /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
pushd ~/git_repos
git clone git://git.cairographics.org/git/py2cairo
cd py2cairo
./autogen.sh --prefix=/usr
make
as_root make install
popd
as_root rm -rf ~/git_repos/py2cairo
# Add to list of installed programs on this system
echo "Py2cairo" >> /list-$CHRISTENED"-"$SURNAME
#