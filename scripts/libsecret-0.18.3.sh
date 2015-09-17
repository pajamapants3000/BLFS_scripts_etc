#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libsecret-0.18.3
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
#gnome_keyring-3.16.0
#gobject_introspection-1.44.0
#libgcrypt-1.6.3
#vala-0.28.1 
# End Recommended
# Begin Optional
#gtk_doc-1.24
#docbook_xml-4.5
#docbook_xsl-1.78.1
#libxslt-1.1.28
#d_bus_python-1.2.0
#gjs-1.43.3
#pygobject-2.28.6 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libsecret-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libsecret/0.18/libsecret-0.18.3.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libsecret/0.18/libsecret-0.18.3.tar.xz
#
# md5sum:
echo "a21605644a64883ab685aec50d63253e libsecret-0.18.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsecret-0.18.3.tar.xz
pushd libsecret-0.18.3
./configure --prefix=/usr --disable-static
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
# Test (from GUI session started with d_bus launch):
#make -j${PARALLEL} check
popd
as_root rm -rf libsecret-0.18.3
#
# Add to installed list for this computer:
echo "libsecret-0.18.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################