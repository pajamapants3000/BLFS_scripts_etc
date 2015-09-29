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
#atk-2.16.0
#gdk_pixbuf-2.31.6
#pango-1.36.8
# End Required
# Begin Recommended
#hicolor-icon-theme-0.15
# End Recommended
# Begin Optional
#cups-2.0.4
#docbook_utils-0.6.14
#gobject_introspection-1.44.0
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gtk+-2.24.28 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.28.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.28.tar.xz
#
# md5sum:
echo "bfacf87b2ea67e4e5c7866a9003e6526 gtk+-2.24.28.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtk+-2.24.28.tar.xz
cd gtk+-2.24.28
sed -i 's#l \(gtk-.*\).sgml#& -o \1#' docs/{faq,tutorial}/Makefile.in
sed -i -e 's#pltcheck.sh#$(NULL)#g' gtk/Makefile.in
./configure --prefix=/usr --sysconfdir=/etc 
make -j$PARALLEL
# Test (run in X-Window session):
make check
#
as_root make -j$PARALLEL install
cd ..
as_root rm -rf gtk+-2.24.28
#
# Add to installed list for this computer:
echo "gtk+-2.24.28" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
