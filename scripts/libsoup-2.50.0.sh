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
#glib_networking-2.44.0
#libxml2-2.9.2
#sqlite-3.8.11.1 
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
# End Recommended
# Begin Optional
#apache-2.4.16
#curl-7.44.0
#gtk_doc-1.24
#php-5.6.12
#samba-4.2.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libsoup-2.50.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libsoup/2.50/libsoup-2.50.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libsoup/2.50/libsoup-2.50.0.tar.xz
#
# md5sum:
echo "9a84d66e1b7ccd3bd340574b11eccc15 libsoup-2.50.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libsoup-2.50.0.tar.xz
cd libsoup-2.50.0
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libsoup-2.50.0
#
# Add to installed list for this computer:
echo "libsoup-2.50.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################