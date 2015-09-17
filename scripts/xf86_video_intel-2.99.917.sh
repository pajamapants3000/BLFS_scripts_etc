#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xf86_video_intel-2.99.917
#
# Dependencies
#**************
# Begin Required
#xcb_util-0.4.0
#xorg_server-1.17.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
#CONFIG_DRM
#CONFIG_DRM_I810
#CONFIG_DRM_I915
#CONFIG_DRM_I915_KMS
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "xf86_video_intel-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/driver/xf86-video-intel-2.99.917.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/driver/xf86-video-intel-2.99.917.tar.bz2
#
# md5sum:
echo "fa196a66e52c0c624fe5d350af7a5e7b xf86-video-intel-2.99.917.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xf86-video-intel-2.99.917.tar.bz2
cd xf86-video-intel-2.99.917
./configure $XORG_CONFIG --enable-kms-only --enable-uxa
make
#
as_root make install
cd ..
as_root rm -rf xf86-video-intel-2.99.917
#
# Add to installed list for this computer:
echo "xf86_video_intel-2.99.917" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
as_root tee -a /etc/X11/xorg.conf.d/20-intel.conf << "EOF"
Section "Device"
        Identifier "Intel Graphics"
        Driver "intel"
        Option "AccelMethod" "uxa"
EndSection
EOF
#