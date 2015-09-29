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
#gtk+-2.24.28
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
#gtk_doc-1.24
#pygtk-2.24.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep vte-0.28.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/vte/0.28/vte-0.28.2.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/vte/0.28/vte-0.28.2.tar.xz
#
# md5sum:
echo "497f26e457308649e6ece32b3bb142ff vte-0.28.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf vte-0.28.2.tar.xz
cd vte-0.28.2
./configure --prefix=/usr \
            --libexecdir=/usr/lib/vte \
            --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf vte-0.28.2
#
# Add to installed list for this computer:
echo "vte-0.28.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################