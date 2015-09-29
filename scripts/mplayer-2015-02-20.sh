#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#yasm-1.3.0
# End Required
# Begin Recommended
#gtk+-2.24.26
#libvdpau-0.9
# End Recommended
# Begin Optional
#cdparanoia-III-10.2
#libdvdread-5.0.2
#libdvdnav-5.0.3
#libdvdcss-1.3.0
#samba-4.1.17
#libbluray
#libcdio
#live555
#rtmpdump
#tivo
#xmms
#alsa-1.0.28
#pulseaudio-5.0
#sdl-1.2.15
#jack
#nas
#openal
#aalib-1.4rc5
#giflib-5.1.1
#libjpeg_turbo-1.4.0
#libmng-2.0.2
#libpng-1.6.16
#openjpeg-1.5.2
#directfb
#libcaca
#svga_lib
#faac-1.28
#faad2-2.7
#lame-3.99.5
#liba52-0.7.4
#libdv-1.0.0
#libmad-0.15.1b
#libmpeg2-0.5.1
#libtheora-1.1.1
#libvpx-1.3.0
#lzo-2.09
#mpg123-1.22.0
#speex-1.2rc2
#xvid-1.3.3
#x264-20141208-2245
#crystalhd
#dirac
#gsm
#ilbc
#libdca
#libnut
#libmpcdec
#opencore
#schroedinger
#tremor
#twolame
#fontconfig-2.11.1
#freetype-2.5.5
#fribidi-0.19.7
#gnutls-3.3.12
#openssl-1.0.2
#opus-1.1
#unrar-5.2.6
#libxslt-1.1.28
#docbook_xml-4.5
#docbook_xsl-1.78.1
#enca
#ladspa
#libbs2b
#lirc
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep mplayer-2015-02-20 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/other/mplayer-2015-02-20.tar.xz
# md5sum:
echo "466277d34edee7facd456cddfca10171 mplayer-2015-02-20.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional skin download
wget http://www.mplayerhq.hu/MPlayer/skins/Clearlooks-1.6.tar.bz2
# Alt.
#wget ftp://ftp.mplayerhq.hu/MPlayer/skins/Clearlooks-1.6.tar.bz2
#
tar -xvf mplayer-2015-02-20.tar.xz
cd mplayer-2015-02-20
sed -i 's:libsmbclient.h:samba-4.0/&:' configure stream/stream_smb.c
./configure --prefix=/usr            \
            --confdir=/etc/mplayer   \
            --enable-dynamic-plugins \
            --enable-menu            \
            --enable-gui
make
#
as_root make install
as_root ln -svf ../icons/hicolor/48x48/apps/mplayer.png \
        /usr/share/pixmaps/mplayer.png
as_root install -v -m755 -d /usr/share/doc/mplayer-2015-02-20
as_root install -v -m644    DOCS/HTML/en/* \
                    /usr/share/doc/mplayer-2015-02-20
as_root install -v -m644 etc/codecs.conf /etc/mplayer
as_root install -v -m644 etc/*.conf /etc/mplayer
# If have gtk 2 or 3
gtk-update-icon-cache
# If have desktop_file_utils-0.22
update-desktop-database
# Install skin if downloaded
as_root tar -xvf  ../Clearlooks-1.6.tar.bz2 \
    -C    /usr/share/mplayer/skins
as_root ln  -sfvn Clearlooks /usr/share/mplayer/skins/default
cd ..
as_root rm -rf mplayer-2015-02-20
#
# Add to installed list for this computer:
echo "mplayer-2015-02-20" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################