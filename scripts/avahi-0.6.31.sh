#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for avahi-0.6.31
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
#gtk+-2.24.28
#gtk+-3.16.6
#libdaemon-0.14
#libglade-2.6.4
# End Recommended
# Begin Optional
#d_bus_python-1.2.0
#pygtk-2.24.0
#qt-4.8.7
# End Optional
# Begin Kernel
# End Kernel
#
if [ $QTDIR = $QT5DIR ]; then
    source setqt4
    QTMOD=1
fi
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep avahi-0.6.31 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://avahi.org/download/avahi-0.6.31.tar.gz
#
# md5sum:
echo "2f22745b8f7368ad5a0a3fddac343f2d avahi-0.6.31.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
#
if ! (cat /etc/group | grep avahi > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -fg 84 avahi
    as_root useradd -c "Avahi_Daemon_Owner" -d /var/run/avahi-daemon -u 84 \
            -g avahi -s /bin/false avahi
    as_root groupadd -fg 86 netdev
    pathremove /usr/sbin
fi
#
tar -xvf avahi-0.6.31.tar.gz
cd avahi-0.6.31
sed -i 's/\(CFLAGS=.*\)-Werror \(.*\)/\1\2/' configure
sed -e 's/-DG_DISABLE_DEPRECATED=1//' \
    -e '/-DGDK_DISABLE_DEPRECATED/d'  \
    -i avahi-ui/Makefile.in
# --disable-qt4 if not installed; remove --disable-gtk/gtk3 for gtk systems
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --disable-mono       \
            --disable-monodoc    \
            --disable-python     \
            --disable-qt3        \
            --disable-gtk        \
            --disable-gtk3        \
            --enable-core-docs   \
            --with-distro=none   \
            --with-systemdsystemunitdir=no
make
#
as_root make install
cd ..
as_root rm -rf avahi-0.6.31
#
# Add to installed list for this computer:
echo "avahi-0.6.31" >> /list-$CHRISTENED"-"$SURNAME
#
(($QTMOD)) && source setqt5 || ( exit 0 )
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-avahi
cd ..
#
###################################################
