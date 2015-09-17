#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for dbus-1.8.20
# Updated 07/25/2015
#
# Dependencies
#**************
# Begin Required
#Xorg Libraries
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dbus_glib-0.104
#dbus_python-1.2.0
#pygobject-2.28.6
#doxygen-1.8.10
#xmlto-0.0.26
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep dbus-1.8.20 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dbus.freedesktop.org/releases/dbus/dbus-1.8.20.tar.gz
# md5sum:
echo "b49890bbabedab3a1c3f4f73c7ff8b2b dbus-1.8.20.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf dbus-1.8.20.tar.gz
cd dbus-1.8.20
#
if ! (cat /etc/group | grep messagebus > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 18 messagebus
    as_root useradd -c "D-Bus_Message_Daemon_User" -d /var/run/dbus \
            -u 18 -g messagebus -s /bin/false messagebus
    pathremove /usr/sbin
fi
#
./configure --prefix=/usr                  \
            --sysconfdir=/etc              \
            --localstatedir=/var           \
            --disable-doxygen-docs         \
            --disable-xml-docs             \
            --disable-static               \
            --disable-systemd              \
            --without-systemdsystemunitdir \
            --with-console-auth-dir=/run/console/ \
            --docdir=/usr/share/doc/dbus-1.8.20
make
#
as_root make install
cd ..
as_root rm -rf dbus-1.8.20
#
# Add to installed list for this computer:
echo "dbus-1.8.20" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-dbus
cd ..
#
###################################################
#
# Configuration
#***************
#
# There is a lot to this. While the system-wide daemon is running,
# a session daemon must still be launched; e.g. put dbus-launch in
# .xsession or .xinitrc.
###################################################
#
# Avoid warnings if still building more packages that depend on dbus
as_root dbus-uuidgen --ensure
#
###################################################
