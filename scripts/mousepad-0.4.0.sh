#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for mousepad-0.4.0
#
# Dependencies
#**************
# Begin Required
#gtksourceview-3.16.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dbus_glib-0.104
#gtksourceview-2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep mousepad-0.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/mousepad/0.4/mousepad-0.4.0.tar.bz2
# md5sum:
echo "f55314c5dda6323883241e6cf01550a7 mousepad-0.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf mousepad-0.4.0.tar.bz2
cd mousepad-0.4.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf mousepad-0.4.0
#
# Add to installed list for this computer:
echo "mousepad-0.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################