#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libwnck-2.30.7
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.28
# End Required
# Begin Recommended
#startup_notification-0.12
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
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
grep libwnck-2.30.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
#
# md5sum:
echo "3d20f26105a2fd878899d6ecdbe9a082 libwnck-2.30.7.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libwnck-2.30.7.tar.xz
cd libwnck-2.30.7
./configure --prefix=/usr \
            --disable-static \
            --program-suffix=-1
make GETTEXT_PACKAGE=libwnck-1
#
as_root make GETTEXT_PACKAGE=libwnck-1 install
cd ..
as_root rm -rf libwnck-2.30.7
#
# Add to installed list for this computer:
echo "libwnck-2.30.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################