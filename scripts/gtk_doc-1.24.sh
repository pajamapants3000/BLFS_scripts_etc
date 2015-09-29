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
#docbook_xml-4.5
#docbook_xsl-1.78.1
#itstool-2.0.2
#libxslt-1.1.28 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dblatex
#fop-1.1
#glib-2.44.1
#gnome_doc_utils
#which-2.21
#openjade-1.3.2
#docbook-4.5
#docbook_dsssl-1.79
#python-2.7.10
#rarian-0.8.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gtk_doc-1.24 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.24/gtk-doc-1.24.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.24/gtk-doc-1.24.tar.xz
#
# md5sum:
echo "a8b96bacaba04e83531abf8e36d4e476 gtk-doc-1.24.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtk-doc-1.24.tar.xz
cd gtk-doc-1.24
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gtk-doc-1.24
#
# Add to installed list for this computer:
echo "gtk_doc-1.24" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################