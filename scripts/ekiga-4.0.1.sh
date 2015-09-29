#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#boost-1.59.0
#gnome_icon_theme-3.12.0
#gtk+-2.24.28
#opal-3.10.10
# End Required
# Begin Recommended
#dbus_glib-0.104
#gconf-3.2.6
#libnotify-0.7.6
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
grep "ekiga-4.0.1" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/ekiga/4.0/ekiga-4.0.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/ekiga/4.0/ekiga-4.0.1.tar.xz
#
# md5sum:
echo "704ba532a8e3e0b5e3e2971dd2db39e4 ekiga-4.0.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ekiga-4.0.1.tar.xz
cd ekiga-4.0.1
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-eds     \
            --disable-gdu     \
            --disable-ldap    \
            --disable-scrollkeeper
make
#
as_root make install
cd ..
as_root rm -rf ekiga-4.0.1
#
# Add to installed list for this computer:
echo "ekiga-4.0.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#