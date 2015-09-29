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
#cairo-1.14.2
#flac-1.3.1
#gdk_pixbuf-2.31.6
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#libsoup-2.50.0
#libvpx-1.4.0
#Xorg Libraries
# End Recommended
# Begin Optional
#aalib-1.4rc5
#gtk+-3.16.6
#gtk_doc-1.24
#libdv-1.0.0
#libgudev-230
#pulseaudio-6.0
#speex-1.2rc2
#taglib-1.9.1
#valgrind-3.10.1
#v4l_utils-1.6.3
#jack
#libcaca
#libiec61883
#libraw1394
#libshout
#orc
#wavpack
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gst_plugins_good-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.4.5.tar.xz
# md5sum:
echo "eaf1a6daf73749bc423feac301d60038 gst-plugins-good-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gst-plugins-good-1.4.5.tar.xz
cd gst-plugins-good-1.4.5
./configure --prefix=/usr \
            --with-package-name="GStreamer Good Plugins 1.4.5 BLFS" \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/"
make
# Test (some known to fail):
#make -k check
#
as_root make install
cd ..
as_root rm -rf gst-plugins-good-1.4.5
#
# Add to installed list for this computer:
echo "gst_plugins_good-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################