#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libnotify-0.7.6
#
# Dependencies
#**************
# Begin Required
#gtk+-3.16.6
# End Required
# Begin Required Runtime
#xfce4-notifyd-0.2.4
#notification-daemon-3.14.1
# End Required Runtime
# Begin Recommended
# End Recommended
# Begin Optional
#gobject-introspection-1.42.0
#GTK-Doc-1.21
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libnotify-0.7.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libnotify/0.7/libnotify-0.7.6.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libnotify/0.7/libnotify-0.7.6.tar.xz
#
# md5sum:
echo "a4997019d08f46f3bf57b78e6f795a59 libnotify-0.7.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libnotify-0.7.6.tar.xz
cd libnotify-0.7.6
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libnotify-0.7.6
#
# Add to installed list for this computer:
echo "libnotify-0.7.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################