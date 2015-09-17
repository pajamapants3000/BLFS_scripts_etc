#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for atkmm-2.22.7
#
# Dependencies
#**************
# Begin Required
#atk-2.14.0
#glibmm-2.42.0
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
grep atkmm-2.22.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/atkmm/2.22/atkmm-2.22.7.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/atkmm/2.22/atkmm-2.22.7.tar.xz
#
# md5sum:
echo "fec7db3fc47ba2e0c95d130ec865a236 atkmm-2.22.7.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
cd atkmm-2.22.7
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf atkmm-2.22.7
#
# Add to installed list for this computer:
echo "atkmm-2.22.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################