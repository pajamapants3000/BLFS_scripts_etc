#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gtk+-3.16.6
#
# Dependencies
#**************
# Begin Required
#at_spi2_atk-2.16.0
#gdk_pixbuf-2.31.6
#pango-1.36.8
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
#adwaita_icon_theme-3.16.2.1
#colord-1.2.12
#cups-2.0.4
#docbook_utils-0.6.14
#gtk_doc-1.24
#hicolor_icon_theme-0.15
#json-glib-1.0.4
#rest
#libxkbcommon
#Wayland
# End Optional
# Begin Kernel
# End Kernel
#
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gtk+-3.16.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtk+/3.16/gtk+-3.16.6.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtk+/3.16/gtk+-3.16.6.tar.xz
#
# md5sum:
echo "fc59e5c8b5a4585b60623dd708df400b gtk+-3.16.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtk+-3.16.6.tar.xz
cd gtk+-3.16.6
./configure --prefix=/usr             \
            --sysconfdir=/etc         \
            --enable-broadway-backend \
            --enable-x11-backend      \
            --disable-wayland-backend
make -j$PARALLEL
# Test (need a graphical session):
#as_root glib-compile-schemas /usr/share/glib-2.0/schemas
#make check
#
as_root make -j$PARALLEL install
cd ..
as_root rm -rf gtk+-3.16.6
#
mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/settings.ini << "EOF"
[Settings]
gtk-theme-name = Adwaita
gtk-fallback-icon-theme = gnome
EOF
as_root tee /etc/gtk-3.0/settings.ini << "EOF"
[Settings]
gtk-theme-name = Clearwaita
gtk-fallback-icon-theme = elementary
EOF
# Add to installed list for this computer:
echo "gtk+-3.16.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
