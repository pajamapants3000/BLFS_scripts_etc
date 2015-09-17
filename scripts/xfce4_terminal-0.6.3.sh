#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xfce4_terminal-0.6.3
#
# Dependencies
#**************
# Begin Required
#libxfce4ui-4.12.1
#vte-0.28.2
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
REINSTALL=0
grep xfce4_terminal-0.6.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/xfce4-terminal/0.6/xfce4-terminal-0.6.3.tar.bz2
#
# md5sum:
echo "6a2816d8b0933cd707ed456ceb731399 xfce4-terminal-0.6.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-terminal-0.6.3.tar.bz2
cd xfce4-terminal-0.6.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xfce4-terminal-0.6.3
#
# Add to installed list for this computer:
echo "xfce4_terminal-0.6.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################