#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Installation script for keybinder-0.3.0
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.26
# End Required
# Begin Recommended
#gobject-introspection-1.42.0
#pygtk-2.24.0 
# End Recommended
# Begin Optional
#gtk_doc-1.21
#lua-5.3.0 (currently broken)
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep keybinder-0.3.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://pkgs.fedoraproject.org/repo/pkgs/keybinder/keybinder-0.3.0.tar.gz/2a0aed62ba14d1bf5c79707e20cb4059/keybinder-0.3.0.tar.gz
# md5sum:
echo "2a0aed62ba14d1bf5c79707e20cb4059 keybinder-0.3.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf keybinder-0.3.0.tar.gz
cd keybinder-0.3.0
./configure --prefix=/usr --disable-lua
make
#
as_root make install
cd ..
as_root rm -rf keybinder-0.3.0
#
# Add to installed list for this computer:
echo "keybinder-0.3.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################