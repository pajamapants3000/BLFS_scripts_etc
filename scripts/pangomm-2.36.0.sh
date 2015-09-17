#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for pangomm-2.36.0
#
# Dependencies
#**************
# Begin Required
#cairomm-1.10.0
#glibmm-2.44.0
#pango-1.36.8 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pangomm-2.36.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pangomm/2.36/pangomm-2.36.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/pangomm/2.36/pangomm-2.36.0.tar.xz
#
# md5sum:
echo "62910723211d86ab825b666b479871c9 pangomm-2.36.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pangomm-2.36.0.tar.xz
cd pangomm-2.36.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf pangomm-2.36.0
#
# Add to installed list for this computer:
echo "pangomm-2.36.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################