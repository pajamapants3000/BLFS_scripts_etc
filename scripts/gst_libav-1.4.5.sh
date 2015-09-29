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
#yasm-1.3.0
# End Recommended
# Begin Optional
#valgrind-3.10.1
#orc
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gst_libav-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.4.5.tar.xz
# md5sum:
echo "f4922a46adbcbe7bd01331ff5dc7979d gst-libav-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gst-libav-1.4.5.tar.xz
cd gst-libav-1.4.5
./configure --prefix=/usr \
            --with-package-name="GStreamer Libav Plugins 1.4.5 BLFS" \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/"
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gst-libav-1.4.5
#
# Add to installed list for this computer:
echo "gst_libav-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################