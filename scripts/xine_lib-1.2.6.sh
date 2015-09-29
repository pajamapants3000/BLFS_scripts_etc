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
#x_window_system
#ffmpeg-2.7.2
#alsa-1.0.29
#pulseaudio-6.0
#jack
# End Required
# Begin Recommended
#libdvdnav-5.0.3
# End Recommended
# Begin Optional
#aalib-1.4rc5
#faad2-2.7
#flac-1.3.1
#gdk_pixbuf-2.31.6
#glu-9.0.0
#imagemagick-6.9.1-0
#liba52-0.7.4
#libmad-0.15.1b
#libmng-2.0.3
#libtheora-1.1.1
#libva-1.6.0
#libvdpau-1.1
#libvorbis-1.3.5
#libvpx-1.4.0
#mesa-10.6.5
#samba-4.2.3
#sdl-1.2.15
#speex-1.2rc2
#doxygen-1.8.10
#v4l_utils-1.6.3
#directfb
#libbluray
#libcaca
#libdca
#libfame
#libmodplug
#musepack
#vcdimager
# wavpack
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "xine_lib-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/xine/xine-lib-1.2.6.tar.xz
# FTP/alt Download:
#wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/xine-lib-1.2.6.tar.xz
#
# md5sum:
echo "02ee3c2380273989b4b016903209e05e xine-lib-1.2.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xine-lib-1.2.6.tar.xz
cd xine-lib-1.2.6
if (cat /list-${CHRISTENED}-${SURNAME} | grep libdvdnav > /dev/null); then
./configure --prefix=/usr          \
            --disable-vcd          \
            --with-external-dvdnav \
            --docdir=/usr/share/doc/xine-lib-1.2.6
else
./configure --prefix=/usr          \
            --disable-vcd          \
            --docdir=/usr/share/doc/xine-lib-1.2.6
fi
make
# with doxygen, build API docs
#doxygen doc/Doxyfile
#
as_root make install
# with doxygen, install API docs
#as_root install -v -m755 -d /usr/share/doc/xine-lib-1.2.6/api
#as_root install -v -m644    doc/api/* \
#                    /usr/share/doc/xine-lib-1.2.6/api
cd ..
as_root rm -rf xine-lib-1.2.6
#
# Add to installed list for this computer:
echo "xine_lib-1.2.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
