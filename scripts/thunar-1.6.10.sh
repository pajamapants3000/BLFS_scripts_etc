#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for thunar-1.6.10
#
# Dependencies
#**************
# Begin Required
#exo-0.10.6
#libxfce4ui-4.12.1
#gnome_icon_theme-3.12.0
#lxde_icon_theme-0.5.1
# End Required
# Begin Recommended
#libgudev-230
#libnotify-0.7.6
#xfce4_panel-4.12.0
# End Recommended
# Begin Optional
#gvfs-1.24.2
#libexif-0.6.21
#tumbler-0.1.31
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep thunar-1.6.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/thunar/1.6/Thunar-1.6.10.tar.bz2
# md5sum:
echo "3089e1dca6e408641b07cd9c759dea5e Thunar-1.6.10.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf Thunar-1.6.10.tar.bz2
cd Thunar-1.6.10
# Change category of thunar, a file manager, from system to utilities
# is .in.in right?
sed -i 's/System;//' Thunar.desktop.in.in
#
./configure --prefix=/usr \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/Thunar-1.6.10
make
#
as_root make install
cd ..
as_root rm -rf Thunar-1.6.10
#
# Add to installed list for this computer:
echo "thunar-1.6.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################