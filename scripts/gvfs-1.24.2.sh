#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gvfs-1.24.2
#
# Dependencies
#**************
# Begin Required
#d_bus-1.8.20
#glib-2.44.1
# End Required
# Begin Recommended
#gtk+-3.16.6
#libgudev-230
#libsecret-0.18.3
#libsoup-2.50.0
#udisks-2.1.6
# End Recommended
# Begin Optional
#apache-2.4.16
#avahi-0.6.31
#bluez-5.32
#dbus_glib-0.104
#fuse-2.9.4
#gtk_doc-1.24
#libarchive-3.1.2
#libcdio-0.93
#libgcrypt-1.6.3
#libxml2-2.9.2
#libxslt-1.1.28
#openssh-7.1p1
#samba-4.2.3
#gnome_online_accounts
#libbluray
#libgphoto2
#libimobiledevice
#libmtp
#twisted
# End Optional
# Begin Optional Runtime
#obex_data_server-0.4.6
# End Optional Runtime
# Begin Kernel
# End Kernel
#
# NOTE: libxslt and docbook_xsl should be recommended; won't compile without!
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gvfs-1.24.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gvfs/1.24/gvfs-1.24.2.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gvfs/1.24/gvfs-1.24.2.tar.xz
#
# md5sum:
echo "83ed317eb2a5264715d4273e90a5cfd8 gvfs-1.24.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
CONFIG_FLAGS="--prefix=/usr \
            --sysconfdir=/etc \
            --disable-gphoto2"
if ! (cat /list-${CHRISTENED}-{SURNAME} | grep "gtk+" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --disable-gtk"
fi
if ! (cat /list-${CHRISTENED}-{SURNAME} | grep "udisks" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --disable-udisks2"
fi
tar -xvf gvfs-1.24.2.tar.xz
cd gvfs-1.24.2
./configure ${CONFIG_FLAGS}
make
#
as_root make install
cd ..
as_root rm -rf gvfs-1.24.2
#
# Add to installed list for this computer:
echo "gvfs-1.24.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################