#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxmenu_data-0.1.4
#
# Dependencies
#**************
# Begin Required
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
grep lxmenu_data-0.1.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lxde/lxmenu-data-0.1.4.tar.xz
#
# md5sum:
echo "a44bb6214594fee21b8ef3e478b0f0e5 lxmenu-data-0.1.4.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxmenu-data-0.1.4.tar.xz
cd lxmenu-data-0.1.4
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf lxmenu-data-0.1.4
#
# Add to installed list for this computer:
echo "lxmenu_data-0.1.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
