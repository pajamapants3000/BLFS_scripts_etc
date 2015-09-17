#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gtkmm-2.24.4
#
# Dependencies
#**************
# Begin Required
#atkmm-2.22.7
#gtk+-2.24.26
#pangomm-2.34.0
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
grep gtkmm-2.24.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gtkmm/2.24/gtkmm-2.24.4.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gtkmm/2.24/gtkmm-2.24.4.tar.xz
#
# md5sum:
echo "b9ac60c90959a71095f07f84dd39961d gtkmm-2.24.4.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gtkmm-2.24.4.tar.xz
cd gtkmm-2.24.4
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gtkmm-2.24.4
#
# Add to installed list for this computer:
echo "gtkmm-2.24.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################