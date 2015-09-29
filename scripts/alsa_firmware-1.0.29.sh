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
#alsa_tools-1.0.29
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#as31
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep alsa_firmware-1.0.29 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://alsa.cybermirror.org/firmware/alsa-firmware-1.0.29.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.alsa-project.org/pub/firmware/alsa-firmware-1.0.29.tar.bz2
#
# md5sum:
echo "9a1182f8a6ac44cb9af5774cc045565f alsa-firmware-1.0.29.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf alsa-firmware-1.0.29.tar.bz2
cd alsa-firmware-1.0.29
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf alsa-firmware-1.0.29
#
# Add to installed list for this computer:
echo "alsa_firmware-1.0.29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################