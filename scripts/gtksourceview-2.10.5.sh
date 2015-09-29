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
#gtk+-2.24.26
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
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
grep gtksourceview-2.10.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtksourceview/2.10/gtksourceview-2.10.5.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtksourceview/2.10/gtksourceview-2.10.5.tar.gz
#
# md5sum:
echo "220db5518e3f7fa06c980f057b22ba62 gtksourceview-2.10.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtksourceview-2.10.5.tar.gz
cd gtksourceview-2.10.5
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gtksourceview-2.10.5
#
# Add to installed list for this computer:
echo "gtksourceview-2.10.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################