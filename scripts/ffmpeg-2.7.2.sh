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
#libass-0.12.3
#fdk_aac-0.1.4
#freetype-2.6
#lame-3.99.5
#libtheora-1.1.1
#libvorbis-1.3.5
#libvpx-1.4.0
#opus-1.1
#x264-20141208-2245
#yasm-1.3.0
#alsa-lib-1.0.29
#libva-1.6.0
#libvdpau-1.1
#sdl-1.2.15
# End Recommended
# Begin Optional
#faac-1.28
#fontconfig-2.11.1
#libcdio-0.93
#libwebp-0.4.3
#openjpeg-1.5.2
#openssl-1.0.2d
#gnutls-3.4.4.1
#pulseaudio-6.0
#speex-1.2rc2
#texlive-20150521
#v4l_utils-1.6.3
#xvid-1.3.3
#x_window_system
#flite
#frei0r
#gsm
#HEVC/H.265
#ladspa
#libaacplus
#libbluray
#libcaca
#libcelt
#libdc1394
#libdca
#libiec61883
#libilbc
#libmodplug
#libnut
#librtmp
#libssh
#libxavs
#openal
#opencore_amr
#opencv
#schroedinger
#twolame
#vo_aaenc
#vo_amrwbenc
#x265 (H.265/MPEG-H HEVC)
#zvbi
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ffmpeg-2.7.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ffmpeg.org/releases/ffmpeg-2.7.2.tar.bz2
#
# md5sum:
echo "7eb2140bab9f0a8669b65b50c8e4cfb5 ffmpeg-2.7.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ffmpeg-2.7.2.tar.bz2
cd ffmpeg-2.7.2
sed -i 's/-lflite"/-lflite -lasound"/' configure
./configure --prefix=/usr        \
            --enable-gpl         \
            --enable-version3    \
            --enable-nonfree     \
            --disable-static     \
            --enable-shared      \
            --disable-debug      \
            --enable-libass      \
            --enable-libfdk-aac  \
            --enable-libfreetype \
            --enable-libmp3lame  \
            --enable-libopus     \
            --enable-libtheora   \
            --enable-libvorbis   \
            --enable-libvpx      \
            --enable-libx264     \
            --enable-x11grab     \
            --docdir=/usr/share/doc/ffmpeg-2.7.2
make
gcc tools/qt-faststart.c -o tools/qt-faststart
#
# with texlive, build PDF and PS docs
#as_root sed -i '$s/$/\n\n@bye/' doc/{git-howto,nut,fate}.texi
#as_root sed -i '/machine:i386/ s/\\/@backslashchar{}/g' doc/platform.texi
#pushd doc
#for DOCNAME in `basename -s .html *.html`
#do
#    as_root texi2pdf -b $DOCNAME.texi
#    as_root texi2dvi -b $DOCNAME.texi
#    as_root dvips    -o $DOCNAME.ps   \
#                        $DOCNAME.dvi
#done
#popd
#unset DOCNAME
#
# with doxygen, build API docs
#doxygen doc/Doxyfile
#
as_root make install
as_root install -v -m755    tools/qt-faststart /usr/bin
as_root install -v -m644    doc/*.txt \
                    /usr/share/doc/ffmpeg-2.7.2
#
# texlive install docs
as_root install -v -m644 doc/*.pdf \
                 /usr/share/doc/ffmpeg-2.7.2
as_root install -v -m644 doc/*.ps  \
                 /usr/share/doc/ffmpeg-2.7.2
#
# doxygen install docs
#as_root install -v -m755 -d /usr/share/doc/ffmpeg-2.7.2/api
#as_root cp -vr doc/doxy/html/* /usr/share/doc/ffmpeg-2.7.2/api
#find /usr/share/doc/ffmpeg-2.7.2/api -type f -exec as_root chmod -c 0644 \{} \;
#find /usr/share/doc/ffmpeg-2.7.2/api -type d -exec as_root chmod -c 0755 \{} \;
#
# with rsync, run tests
# download ~930MB of sample files
#make fate-rsync SAMPLES=fate-suite/
# or, if using previously saved samples, verify they are identical
#rsync -vrltLW  --delete --timeout=60 --contimeout=60 \
#      rsync://fate-suite.ffmpeg.org/fate-suite/ fate-suite/
# Execute FATE (>2400MB!)
#make fate THREADS=3 SAMPLES=fate-suite/ | tee ../fate.log
#grep ^TEST ../fate.log | wc -l
#
cd ..
as_root rm -rf ffmpeg-2.7.2
#
# Add to installed list for this computer:
echo "ffmpeg-2.7.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
