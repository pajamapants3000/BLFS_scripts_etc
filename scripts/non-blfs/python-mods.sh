#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#python-3.4.2
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
grep python-mods /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Install with pip
as_root pip3 install bpython           \
                     flake8            \
                     nose-cov          \
                     python-coveralls  \
                     xcffib            \
                     cairocffi         \
                     pyglet            \
                     cx-freeze         \
                     peewee
#
# Rebuild cairocffi's cairo library
# Note how we change directories; the output goes in to the current working
#+directory, and if it's not in the site-packages folder, python won't see it!
cd /usr/lib/python3.4/site-packages
as_root python3 cairocffi/ffi_build.py
#
# Add to list of installed programs on this system
echo "python-mods" >> /list-$CHRISTENED"-"$SURNAME
#
