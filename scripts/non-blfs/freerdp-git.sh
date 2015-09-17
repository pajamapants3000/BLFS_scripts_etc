#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for freerdp-git
#
# Dependencies
#**************
# Begin Required
#xorg
#gstreamer-1.4.5
#gst_plugins_base-1.4.5
#libxml2-2.9.2
#alsa_lib-1.0.29
#cups-2.0.4
#ffmpeg-2.7.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#xmlto-0.0.26
#doxygen-1.8.10
#directfb
#cunit
#xtst
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "freerdp-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
git clone git://github.com/FreeRDP/FreeRDP.git
#
cd FreeRDP
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DWITH_SSE2=ON ..
make
#
as_root make install
cd ../..
as_root rm -rf FreeRDP
#
# Add to installed list for this computer:
echo "freerdp-git" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#***************
#
as_root tee -a /etc/ld.so.conf << "EOF"

# Begin FreeRDP additions
/usr/lib/freerdp
# End FreeRDP additions
#
EOF
as_root ldconfig
#
###################################################

