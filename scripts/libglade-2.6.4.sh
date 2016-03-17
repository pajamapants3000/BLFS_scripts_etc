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
#libxml2-2.9.2
#gtk+-2.24.26 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#python-2.7.9
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
grep libglade-2.6.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/libglade/2.6/libglade-2.6.4.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/libglade/2.6/libglade-2.6.4.tar.bz2
#
# md5sum:
echo "d1776b40f4e166b5e9c107f1c8fe4139 libglade-2.6.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libglade-2.6.4.tar.bz2
cd libglade-2.6.4
sed -i '/DG_DISABLE_DEPRECATED/d' glade/Makefile.in
./configure --prefix=/usr --disable-static
make
# Test (one test - test-convert - known to fail):
make check
#
as_root make install
cd ..
as_root rm -rf libglade-2.6.4
#
# Add to installed list for this computer:
echo "libglade-2.6.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
