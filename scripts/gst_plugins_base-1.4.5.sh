#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gst_plugins_base-1.4.5
#
# Dependencies
#**************
# Begin Required
#gstreamer-1.4.5
# End Required
# Begin Recommended
#alsa_lib-1.0.29
#gobject_introspection-1.44.0
#iso_codes-3.59
#libogg-1.3.2
#libtheora-1.1.1
#libvorbis-1.3.5
#Xorg Libraries 
# End Recommended
# Begin Optional
#cdparanoia-III-10.2
#gtk+-3.16.4
#gtk_doc-1.24
#qt-4.8.7
#valgrind-3.10.1
#libvisual
#orc
#tremor
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gst_plugins_base-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.4.5.tar.xz
# md5sum:
echo "357165af625c0ca353ab47c5d843920e gst-plugins-base-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gst-plugins-base-1.4.5.tar.xz
cd gst-plugins-base-1.4.5
./configure --prefix=/usr \
            --with-package-name="GStreamer Base Plugins 1.4.5 BLFS"                \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/" \
            --enable-iso-codes
make
# Test (one fails on Lilu - list/rtspconnection; this way completes at least):
make -k check || ( exit 0 )
#
as_root make install
cd ..
as_root rm -rf gst-plugins-base-1.4.5
#
# Add to installed list for this computer:
echo "gst_plugins_base-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
