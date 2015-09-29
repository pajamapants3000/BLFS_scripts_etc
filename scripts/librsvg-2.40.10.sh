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
#gdk_pixbuf-2.31.6
#libcroco-0.6.8
#pango-1.36.8 
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
#gtk+-3.16.6
#vala-0.28.1 
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Preparation
#*************
source blfs_profile
#
CONFOPTS="--prefix=/usr --disable-static"
if ! (cat /list-${CHRISTENED}-${SURNAME} | \
        grep gobject_introspection > /dev/null); then
    CONFOPTS="$CONFOPTS --disable-introspection"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep vala > /dev/null); then
    CONFOPTS="$CONFOPTS -enable-vala"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep gtk_doc > /dev/null); then
    CONFOPTS="$CONFOPTS --enable-gtk-doc"
fi
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "librsvg-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/librsvg/2.40/librsvg-2.40.10.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/librsvg/2.40/librsvg-2.40.10.tar.xz
#
# md5sum:
echo "fadebe2e799ab159169ee3198415ff85 librsvg-2.40.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf librsvg-2.40.10.tar.xz
cd librsvg-2.40.10
./configure $CONFOPTS
make -j${PARALLEL}
# Test:
make -j${PARALLEL} check
#
as_root make -j${PARALLEL} install
cd ..
as_root rm -rf librsvg-2.40.10
#
# Add to installed list for this computer:
echo "librsvg-2.40.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################