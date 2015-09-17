#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for dbus_glib-0.104
#
# Dependencies
#**************
# Begin Required
#d_bus-1.8.18
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep dbus_glib-0.104 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.104.tar.gz
# md5sum:
echo "5497d2070709cf796f1878c75a72a039 dbus-glib-0.104.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf dbus-glib-0.104.tar.gz
cd dbus-glib-0.104
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf dbus-glib-0.104
#
# Add to installed list for this computer:
echo "dbus_glib-0.104" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################