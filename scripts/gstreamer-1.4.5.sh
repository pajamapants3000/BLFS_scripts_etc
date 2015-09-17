#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gstreamer-1.4.5
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
# End Recommended
# Begin Optional
#gsl-1.16
#gtk_doc-1.24
#valgrind-3.10.1 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gstreamer-1.4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.4.5.tar.xz
# md5sum:
echo "88a9289c64a4950ebb4f544980234289 gstreamer-1.4.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gstreamer-1.4.5.tar.xz
cd gstreamer-1.4.5
./configure --prefix=/usr \
            --with-package-name="GStreamer 1.4.5 BLFS" \
            --with-package-origin="http://www.linuxfromscratch.org/blfs/view/svn/"
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gstreamer-1.4.5
#
# Add to installed list for this computer:
echo "gstreamer-1.4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
