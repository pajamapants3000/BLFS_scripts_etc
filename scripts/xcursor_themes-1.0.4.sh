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
#Xorg Applications
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
grep xcursor_themes-1.0.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/archive/individual/data/xcursor-themes-1.0.4.tar.bz2
# Alt/FTP Download:
#wget ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.4.tar.bz2
# md5sum:
echo "fdfb0ad9cfceed60e3bfe9f18765aa0d xcursor-themes-1.0.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xcursor-themes-1.0.4.tar.bz2
cd xcursor-themes-1.0.4
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xcursor-themes-1.0.4
#
# Add to installed list for this computer:
echo "xcursor_themes-1.0.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################