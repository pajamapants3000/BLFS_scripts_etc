#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for at_spi2_core-2.16.0
#
# Dependencies
#**************
# Begin Required
 #d_bus-1.8.18
 #glib-2.44.1
 #Xorg Libraries 
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
grep at_spi2_core-2.16.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/at-spi2-core/2.16/at-spi2-core-2.16.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/at-spi2-core/2.16/at-spi2-core-2.16.0.tar.xz
#
# md5sum:
echo "be6eeea370f913b7639b609913b2cf02 at-spi2-core-2.16.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf at-spi2-core-2.16.0.tar.xz
cd at-spi2-core-2.16.0
./configure --prefix=/usr \
            --sysconfdir=/etc
make
# Test (session buss address needed):
#make check
#
as_root make install
cd ..
as_root rm -rf at-spi2-core-2.16.0
#
# Add to installed list for this computer:
echo "at_spi2_core-2.16.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################