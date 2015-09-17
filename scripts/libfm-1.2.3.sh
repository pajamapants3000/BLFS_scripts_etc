#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libfm-1.2.3
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.28
#menu_cache-1.0.0
# End Required
# Begin Recommended
#libexif-0.6.21
#vala-0.28.1
#lxmenu_data-0.1.4
# End Recommended
# Begin Optional
# End Optional
#dbus_glib-0.104
#udisks-1.0.5
#gvfs-1.24.2
#gtk_doc-1.24
# Begin Kernel
# End Kernel
#
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libfm-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/pcmanfm/libfm-1.2.3.tar.xz
# md5sum:
echo "3ff38200701658f7e80e25ed395d92dd libfm-1.2.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libfm-1.2.3.tar.xz
cd libfm-1.2.3
if ! ( cat /list-${CHRISTENED}-${SURNAME} | grep "gtk+-2" > /dev/null ); then
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --without-gtk     \
            --disable-static
else
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static
fi
make -j$PARALLEL
# Test:
make check
#
as_root make -j$PARALLEL install
cd ..
as_root rm -rf libfm-1.2.3
#
# Add to installed list for this computer:
echo "libfm-1.2.3" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script

