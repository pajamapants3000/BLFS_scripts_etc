#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for upower-0.9.23
#
# Dependencies
#**************
# Begin Required
#dbus_glib-0.104
#libgudev-230
#libusb-1.0.19
#polkit-0.113 
# End Required
# Begin Recommended
#pm_utils-1.4.1
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
#gtk_doc-1.24
#python-3.4.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep upower-0.9.23 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://upower.freedesktop.org/releases/upower-0.9.23.tar.xz
# md5sum:
echo "39cfd97bfaf7d30908f20cf937a57634 upower-0.9.23.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf upower-0.9.23.tar.xz
cd upower-0.9.23
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --enable-deprecated  \
            --disable-static
make
# Test (from local gui session started with dbus-launch; some may fail due to
#+missing files):
#make check
#
as_root make install
cd ..
as_root rm -rf upower-0.9.23
#
# Add to installed list for this computer:
echo "upower-0.9.23" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################