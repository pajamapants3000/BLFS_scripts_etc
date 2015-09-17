#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for networkmanager-1.0.6
#
# Dependencies
#**************
# Begin Required
#dbus_glib-0.104
#libgudev-230
#libndp-1.5
#libnl-3.2.25
#nss-3.20 
# End Required
# Begin Recommended
#consolekit-0.4.6
#dhcpcd-6.9.2
#dhcp-4.3.2-client
#gobject_introspection-1.44.0
#iptables-1.4.21
#libsoup-2.50.0
#newt-0.52.18
#polkit-0.113
#upower-0.9.23
#vala-0.28.1 
# End Recommended
# Begin Optional
#bluez-5.32
#gtk_doc-1.24
#qt-4.8.7
#valgrind-3.10.1
#wpa_supplicant-2.4
#libteam
#modemmanager
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep networkmanager-1.0.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/NetworkManager/1.0/NetworkManager-1.0.6.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/NetworkManager/1.0/NetworkManager-1.0.6.tar.xz
#
# md5sum:
echo "00f5f9ec69725a9f9b99366853c6f73e NetworkManager-1.0.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf NetworkManager-1.0.6.tar.xz
cd NetworkManager-1.0.6
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --with-nmtui         \
            --disable-ppp        \
            --with-systemdsystemunitdir=no \
            --docdir=/usr/share/doc/network-manager-1.0.6
make
# Test (requires already active graphical session with bus address):
#make check
#
as_root make install
cd ..
as_root rm -rf NetworkManager-1.0.6
#
# Add to installed list for this computer:
echo "networkmanager-1.0.6" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-networkmanager
cd ..
#
###################################################
#
# Configuration
#***************
#
# Create minimal configuration
as_root tee -a /etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF
###################################################
