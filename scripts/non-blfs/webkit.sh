#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Required: CMake >= 2.8.8, BISON 2.3 or FLEX 2.5.34, Gperf 3.0.1, Perl 5.10.0,
#   PythonInterp 2.6.0
# Recommended: Ruby 1.8.7
# Check for previous installation:
PROCEED="yes"
grep webkit /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://builds.nightly.webkit.org/files/trunk/src/WebKit-r174650.tar.bz2
#
tar -xvf WebKit-r174650.tar.bz2
cd WebKit-r174650
# This is all just guesses so far, I don't think there is a config
#./configure --prefix=/usr
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf WebKit-r174650
# Add to list of installed programs on this system
echo "webkit" >> /list-$CHRISTENED"-"$SURNAME
#