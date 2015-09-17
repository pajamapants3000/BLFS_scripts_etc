#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xf86_video_ati-7.5.0
#
# Dependencies
#**************
# Begin Required
#xorg_server-1.17.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
#CONFIG_DRM
#CONFIG_DRM_RADEON
#CONFIG_EXTRA_FIRMWARE="radeon/R700_rlc.bin radeon/RV770_smc.bin radeon/RV770_uvd.bin
#CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xf86-video-ati- /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/driver/xf86-video-ati-7.5.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/driver/xf86-video-ati-7.5.0.tar.bz2
#
# md5sum:
echo "29654190e37310b87e44a14c229967ee xf86-video-ati-7.5.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xf86-video-ati-7.5.0.tar.bz2
cd xf86-video-ati-7.5.0
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xf86-video-ati-7.5.0
#
# Add to installed list for this computer:
echo "xf86_video_ati-7.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
###################################################
#
# Configuration
#
as_root tee ${XORG_PREFIX}/share/X11/xorg.conf.d/20-glamor.conf << "EOF"
Section "Device"
        Identifier "radeon"
        Driver "ati"
        Option "AccelMethod" "glamor"
EndSection
EOF
#
###################################################
