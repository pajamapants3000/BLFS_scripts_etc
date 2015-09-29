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
#gst_plugins_base-1.4.5
# End Required
# Begin Recommended
#libdvdread-5.0.3
#libdvdnav-5.0.3
#llvm-3.6.2
#soundtouch-1.9.0
# End Recommended
# Begin Optional
#bluez-5.32
#curl-7.44.0
#faac-1.28
#faad2-2.7
#gnutls-3.4.4.1
#gtk_doc-1.24
#gtk+-2.24.28
#gtk+-3.16.6
#libass-0.12.3
#libexif-0.6.21
#libgcrypt-1.6.3
#libmpeg2-0.5.1
#libvdpau-1.1
#mesa-10.6.5
#mpg123-1.22.2
#neon-0.30.1
#openjpeg-1.5.2
#openjpeg-2.1.0
#sdl-1.2.15
#valgrind-3.10.1
#Xorg Libraries
#celt
#flite
#game_music_emu
#gsm
#libdca
#libmimic
#libmms
#libofa
#mjpeg_tools
#openal
#orc
#rtmpdump
#schroedinger
#vo_aac
#vo_amrwb
#wayland
#zba
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gst_plugins_bad-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.4.5.tar.xz
# md5sum:
echo "e0bb39412cf4a48fe0397bcf3a7cd451 gst-plugins-bad-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional patch for openjpeg
wget http://www.linuxfromscratch.org/patches/blfs/svn/gst-plugins-bad-1.4.5-openjpeg21-1.patch
#
tar -xvf gst-plugins-bad-1.4.5.tar.xz
cd gst-plugins-bad-1.4.5
patch -Np1 -i ../gst-plugins-bad-1.4.5-openjpeg21-1.patch
sed -i -e 's/ GST_CHECK_FAAD_VERSION / /' \
       -e '/"GST_CHECK_FAAD_VERSION/{
           s/GST_CHECK_FAAD_VERSION //
           s/""/"$"/ }' configure
./configure --prefix=/usr \
            --with-package-name="GStreamer Bad Plugins 1.4.5 BLFS" \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/"
make
# Test (camerabin requires a camera! A couple others require terminal in graphical session):
#make check
#
as_root make install
cd ..
as_root rm -rf gst-plugins-bad-1.4.5
#
# Add to installed list for this computer:
echo "gst_plugins_bad-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
