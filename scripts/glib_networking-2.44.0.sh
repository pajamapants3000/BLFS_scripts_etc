#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for glib-networking-2.44.0
#
# Dependencies
#**************
# Begin Required
#gnutls-3.4.4.1
#gsettings_desktop_schemas-3.16.1 
# End Required
# Begin Recommended
#certdata
#p11_kit-0.23.1
# End Recommended
# Begin Optional
#libproxy
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep glib-networking-2.44.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/glib-networking/2.44/glib-networking-2.44.0.tar.xz
# FTP/alt Download:
#wget  ftp://ftp.gnome.org/pub/gnome/sources/glib-networking/2.44/glib-networking-2.44.0.tar.xz
#
# md5sum:
echo "6989b20cf3b26dd5ae272e04a9acb0b3 glib-networking-2.44.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf glib-networking-2.44.0.tar.xz
cd glib-networking-2.44.0
./configure --prefix=/usr                                 \
            --with-ca-certificates=/etc/ssl/ca-bundle.crt \
            --disable-static      
make
# Test:
make -k check
#
as_root make install
cd ..
as_root rm -rf glib-networking-2.44.0
#
# Add to installed list for this computer:
echo "glib-networking-2.44.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################