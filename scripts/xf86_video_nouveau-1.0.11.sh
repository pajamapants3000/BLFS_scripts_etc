#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xf86_video_nouveau-1.0.11
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
#CONFIG_DRM_NOUVEAU
#CONFIG_DRM_NOUVEAU_BACKLIGHT
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xf86-video-nouveau-1.0.11 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/archive/individual/driver/xf86-video-nouveau-1.0.11.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/driver/xf86-video-nouveau-1.0.11.tar.bz2
#
# md5sum:
echo "a0d2932d84ba10c4933c8332c9afe157 xf86-video-nouveau-1.0.11.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xf86-video-nouveau-1.0.11.tar.bz2
cd xf86-video-nouveau-1.0.11
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf xf86-video-nouveau-1.0.11
#
# Add to installed list for this computer:
echo "xf86-video-nouveau-1.0.11" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
###################################################
#
# Configuration
#
# Pick one for single or dual monitor setup
#as_root cp -v files/20-nouveau.conf /etc/X11/xorg.conf.d/
as_root cp -v files/20-nouveau_double.conf /etc/X11/xorg.conf.d/20-nouveau.conf
as_root chown -v root:root /etc/X11/xorg.conf.d/20-nouveau.conf
as_root chmod -v 644 /etc/X11/xorg.conf.d/20-nouveau.conf
#
###################################################
