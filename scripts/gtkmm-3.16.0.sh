#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gtkmm-3.16.0
#
# Dependencies
#**************
# Begin Required
#atkmm-2.22.7
#gtk+-3.16.6
#pangomm-2.36.0
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
grep gtkmm-3.16.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtkmm/3.16/gtkmm-3.16.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtkmm/3.16/gtkmm-3.16.0.tar.xz
#
# md5sum:
echo "daa0c2407e50ff0602236c334c775717 gtkmm-3.16.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtkmm-3.16.0.tar.xz
cd gtkmm-3.16.0
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gtkmm-3.16.0
#
# Add to installed list for this computer:
echo "gtkmm-3.16.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################