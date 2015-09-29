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
# End Required
# Begin Recommended
#alsa_lib-1.0.29
#FFmpeg-2.7.1
#liba52-0.7.4
#libgcrypt-1.6.3 libmad-0.15.1b
#Lua-5.3.1
#X Window System
# End Recommended
# Begin Optional
#d_bus-1.8.18
#libdv-1.0.0
#libdvdcss-1.3.0
#libdvdread-5.0.3
#libdvdnav-5.0.3
#samba-4.2.3
#v4l-utils-1.6.3
#libbluray
#libdc1394
#libcddb
#libproxy
#live555
#opencv
#vcdimager
#libogg-1.3.2
#libdvbpsi
#libshout
#libmatroska
#libmodplug
#musepack
#sidplay-libs,
#faad2-2.7
#flac-1.3.1
#libass-0.12.3
#libmpeg2-0.5.1
#libpng-1.6.18
#libtheora-1.1.1
#libva-1.6.0
#libvorbis-1.3.5
#opus-1.1
#speex-1.2rc2
#x264-20141208-2245
#dirac
#fluidsynth
#libdca
#libkate
#libtiger
#openmax
#schroedinger
#tremor
#twolame
#zapping vbi
#aalib-1.4rc5
#fontconfig-2.11.1
#freetype-2.6
#fribidi-0.19.7
#librsvg-2.40.10
#libvdpau-1.1
#sdl-1.2.15
#libcaca
#pulseaudio-6.0
#libsamplerate-0.1.8
#jack
#qt-4.8.7
#qt-5.5.0
#libtar
#lirc
#goom
#projectm
#avahi-0.6.31
#libmtp
#libupnp
#gnutls-3.4.4.1
#libnotify-0.7.6
#libxml2-2.9.2
#taglib-1.9.1
#xdg-utils-1.1.0-rc3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep vlc-2.2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected
#proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.videolan.org/vlc/2.2.1/vlc-2.2.1.tar.xz
# md5sum:
echo "42273945758b521c408fabc7fd6d9946 vlc-2.2.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf vlc-2.2.1.tar.xz
cd vlc-2.2.1
sed -i 's:libsmbclient.h:samba-4.0/&:' modules/access/smb.c
./bootstrap
./configure --prefix=/usr
sed -i 's/luaL_optint/(int)&eger/'         modules/lua/libs/{net,osd,volume}.c             &&
sed -i 's/luaL_checkint(/(int)luaL_checkinteger(/' \
       modules/lua/{demux,libs/{configuration,net,osd,playlist,stream,variables,volume}}.c
make
# Test (must be run from active X session):
make check
#
as_root make docdir=/usr/share/doc/vlc-2.2.1 install
grep gtk+- /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
as_root gtk-update-icon-cache
grep desktop-file-utils /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
as_root update-desktop-database
cd ..
as_root rm -rf vlc-2.2.1
#
# Add to installed list for this computer:
echo "vlc-2.2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################