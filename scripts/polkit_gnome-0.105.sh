#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for polkit-gnome-0.105
#
# Dependencies
#**************
# Begin Required
#gtk+-3.16.6
#polkit-0.113
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
grep polkit-gnome-0.105 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/polkit-gnome/0.105/polkit-gnome-0.105.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/polkit-gnome/0.105/polkit-gnome-0.105.tar.xz
#
# md5sum:
echo "50ecad37c8342fb4a52f590db7530621 polkit-gnome-0.105.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf polkit-gnome-0.105.tar.xz
cd polkit-gnome-0.105
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf polkit-gnome-0.105
#
# Add to installed list for this computer:
echo "polkit-gnome-0.105" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
as_root mkdir -p /etc/xdg/autostart
as_root tee /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop << "EOF"
[Desktop Entry]
Name=PolicyKit Authentication Agent
Comment=PolicyKit Authentication Agent
Exec=/usr/libexec/polkit-gnome-authentication-agent-1
Terminal=false
Type=Application
Categories=
NoDisplay=true
OnlyShowIn=GNOME;XFCE;Unity;
AutostartCondition=GNOME3 unless-session gnome
EOF
#
##################################################