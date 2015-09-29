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
#glib-2.44.1
#gnutls-3.4.4.1
#libsigc++-2.4.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#libxslt-1.1.28
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep glibmm-2.44.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/glibmm/2.44/glibmm-2.44.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/glibmm/2.44/glibmm-2.44.0.tar.xz
#
# md5sum:
echo "32ee4150b436d097fe2506d0b0b13a75 glibmm-2.44.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf glibmm-2.44.0.tar.xz
cd glibmm-2.44.0
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf glibmm-2.44.0
#
# Add to installed list for this computer:
echo "glibmm-2.44.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################