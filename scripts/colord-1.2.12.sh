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
#d_bus-1.8.18
#glib-2.44.1
#little_cms-2.7
#sqlite-3.8.11.1
# End Required
# Begin Recommended
#valgrind-3.10.1
#gobject_introspection-1.44.0
#libgudev-230
#libgusb-0.2.5
#polkit-0.113
#vala-0.28.1
# End Recommended
# Begin Optional
#docbook_utils-0.6.14
#gnome_desktop-3.16.2
#colord_gtk
#gtk_doc-1.24
#libxslt-1.1.28
#sane-1.0.24
#argllcms
#bash_completion
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep colord-1.2.12 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/colord/releases/colord-1.2.12.tar.xz
# md5sum:
echo "80b106ba18a43c7eeaf2d9a2b8c5725b colord-1.2.12.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf colord-1.2.12.tar.xz
cd colord-1.2.12
if ! cat /etc/group | grep colord > /dev/null; then    
    pathappend /usr/sbin
    as_root groupadd -g 71 colord
    as_root useradd -c "Color_Daemon_Owner" -d /var/lib/colord -u 71 \
            -g colord -s /bin/false colord
    pathremove /usr/sbin
fi
./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --localstatedir=/var         \
            --with-daemon-user=colord    \
            --enable-vala                \
            --enable-systemd-login=no    \
            --disable-argyllcms-sensor   \
            --disable-bash-completion    \
            --disable-static             \
            --with-systemdsystemunitdir=no
make
# Test (some fail for unknown reasons; must have system-wide dbus daemon running):
#make -k check
#
as_root make install
cd ..
as_root rm -rf colord-1.2.12
#
# Add to installed list for this computer:
echo "colord-1.2.12" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
