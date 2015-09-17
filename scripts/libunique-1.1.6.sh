#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libunique-1.1.6
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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libunique-1.1.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libunique/1.1/libunique-1.1.6.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libunique/1.1/libunique-1.1.6.tar.bz2
#
# md5sum:
echo "7955769ef31f1bc4f83446dbb3625e6d libunique-1.1.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/libunique-1.1.6-upstream_fixes-1.patch
tar -xvf libunique-1.1.6.tar.bz2
cd libunique-1.1.6
patch -Np1 -i ../libunique-1.1.6-upstream_fixes-1.patch
autoreconf -fi
./configure --prefix=/usr  \
            --disable-dbus \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libunique-1.1.6
#
# Add to installed list for this computer:
echo "libunique-1.1.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################