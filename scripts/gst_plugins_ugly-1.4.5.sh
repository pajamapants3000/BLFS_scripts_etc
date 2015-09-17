#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gst_plugins_ugly-1.4.5
#
# Dependencies
#**************
# Begin Required
#gst_plugins_base-1.4.5
# End Required
# Begin Recommended
#lame-3.99.5
#libdvdread-5.0.3
#x264-20141208-2245 
# End Recommended
# Begin Optional
#liba52-0.7.4
#libmad-0.15.1b
#libmpeg2-0.5.1
#libcdio-0.93
#libsidplay
#opencore_amr
#orc
#twolame
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gst_plugins_ugly-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.4.5.tar.xz
# md5sum:
echo "6954beed7bb9a93e426dee543ff46393 gst-plugins-ugly-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gst-plugins-ugly-1.4.5.tar.xz
cd gst-plugins-ugly-1.4.5
./configure --prefix=/usr \
            --with-package-name="GStreamer Ugly Plugins 1.4.5 BLFS" \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/"
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gst-plugins-ugly-1.4.5
#
# Add to installed list for this computer:
echo "gst_plugins_ugly-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################