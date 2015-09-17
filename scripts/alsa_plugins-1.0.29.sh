#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for alsa_plugins-1.0.29
#
# Dependencies
#**************
# Begin Required
#alsa_lib-1.0.29
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#ffmpeg-2.7.2
#jack
#libsamplerate-0.1.8
#pulseaudio-6.0
#speex-1.2rc2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep alsa_plugins-1.0.29 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://alsa.cybermirror.org/plugins/alsa-plugins-1.0.29.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.0.29.tar.bz2
#
# md5sum:
echo "a66797b4471e3cbe96575207bfbe252c alsa-plugins-1.0.29.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf alsa-plugins-1.0.29.tar.bz2
cd alsa-plugins-1.0.29
sed -i "/speex_preprocess.h/i#include <stdint.h>" speex/pcm_speex.c
./configure
make
#
as_root make install
cd ..
as_root rm -rf alsa-plugins-1.0.29
#
# Add to installed list for this computer:
echo "alsa_plugins-1.0.29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################