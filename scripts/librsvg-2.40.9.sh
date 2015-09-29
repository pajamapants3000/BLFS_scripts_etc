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
#gdk_pixbuf-2.31.4
#libcroco-0.6.8
#pango-1.36.8 
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
#gtk+-3.16.5
#vala-0.28.0 
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
grep librsvg-2.40.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/librsvg/2.40/librsvg-2.40.9.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/librsvg/2.40/librsvg-2.40.9.tar.xz
#
# md5sum:
echo "31df15e3beaa8fbbf538ca3c52b400d2 librsvg-2.40.9.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf librsvg-2.40.9.tar.xz
cd librsvg-2.40.9
./configure --prefix=/usr    \
            --enable-vala    \
            --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf librsvg-2.40.9
#
# Add to installed list for this computer:
echo "librsvg-2.40.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################