#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Requirements: Xlib header files
# Check for previous installation:
PROCEED="yes"
grep st-0.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dl.suckless.org/st/st-0.5.tar.gz
#
tar -xvf st-0.5.tar.gz
cd st-0.5
#  Apply my own patch:
#  This can be a result of a combination of patches and any other
#+ modifications, all neatly packed in a single file and command!
#  This is great! Apply this to other programs, not just suckless
#+ but I'm especially thinking i3.
patch -p1 < ../patches/st-0.5-transp_soldark.diff
# Though I may later decide to put this in local; something to consider...
as_root make clean install
cd ..
as_root rm -rf st-0.5
# Add to list of installed programs on this system
echo "st-0.5" >> /list-$CHRISTENED"-"$SURNAME
#
