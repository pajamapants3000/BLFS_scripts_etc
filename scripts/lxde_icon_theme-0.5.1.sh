#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxde_icon_theme-0.5.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk+-3.16.6
#gtk+-2.24.28
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep lxde_icon_theme-0.5.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lxde/lxde-icon-theme-0.5.1.tar.xz
#
# md5sum:
echo "7467133275edbbcc79349379235d4411 lxde-icon-theme-0.5.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxde-icon-theme-0.5.1.tar.xz
cd lxde-icon-theme-0.5.1
./configure --prefix=/usr
#
as_root make install
#
grep gtk+ /list-$CHRISTENED"-"$SURNAME > /dev/null && \
gtk-update-icon-cache -qf /usr/share/icons/nuoveXT2 || (exit 0)
#
cd ..
as_root rm -rf lxde-icon-theme-0.5.1
#
# Add to installed list for this computer:
echo "lxde_icon_theme-0.5.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################