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
#alsa-lib-1.0.29
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libsamplerate-0.1.8
#xmlto-0.0.26
#dialog
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep alsa_utils-1.0.29 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://alsa.cybermirror.org/utils/alsa-utils-1.0.29.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.0.29.tar.bz2
#
# md5sum:
echo "6b289bf874c4c9a63f4b3973093dd404 alsa-utils-1.0.29.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf alsa-utils-1.0.29.tar.bz2
cd alsa-utils-1.0.29
./configure --disable-alsaconf --disable-xmlto
make
#
as_root make install
cd ..
as_root rm -rf alsa-utils-1.0.29
#
(($REINSTALL)) && exit 0 || (exit 0)
#
# Add to installed list for this computer:
echo "alsa_utils-1.0.29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Configuration
#
as_root alsactl -L store
#
# Add any desired users to audio group to give them access to devices
#usermod -a -G audio <username>
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-alsa
cd ..
#
###################################################