#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for tumbler-0.1.31
#
# Dependencies
#**************
# Begin Required
#dbus_glib-0.104
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#curl-7.44.0
#ffmpegthumbnailer
#freetype-2.6
#gdk_pixbuf-2.31.6
#gst_plugins_base-1.4.5
#gtk_doc-1.24
#libjpeg_turbo-1.4.1
#libgsf-1.14.33
#libopewnraw
#libpng-1.6.18
#poppler-0.35.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep tumbler-0.1.31 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/tumbler/0.1/tumbler-0.1.31.tar.bz2
# md5sum:
echo "0067054e6f1f90a13f90faadfca1e89e tumbler-0.1.31.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf tumbler-0.1.31.tar.bz2
cd tumbler-0.1.31
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf tumbler-0.1.31
#
# Add to installed list for this computer:
echo "tumbler-0.1.31" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################