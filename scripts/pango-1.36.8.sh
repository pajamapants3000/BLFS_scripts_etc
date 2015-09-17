#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for pango-1.36.8
#
# Dependencies
#**************
# Begin Required
#cairo-1.14.0
#harfbuzz-1.0.2
#Xorg Libraries
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.42.0
#gtk_doc-1.21
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pango-1.36.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.8.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.8.tar.xz
#
# md5sum:
echo "217a9a753006275215fa9fa127760ece pango-1.36.8.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pango-1.36.8.tar.xz
cd pango-1.36.8
./configure --prefix=/usr --sysconfdir=/etc
make
# Test (one known to fail; testing new approach here):
make -k check || (exit 0)
#
as_root make install
cd ..
as_root rm -rf pango-1.36.8
#
# Add to installed list for this computer:
echo "pango-1.36.8" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
