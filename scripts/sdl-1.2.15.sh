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
# End Recommended
# Begin Optional
#alsa_lib-1.0.29
#alsa-plugins-1.0.29
#alsa-utils-1.0.29
#alsa-tools-1.0.29
#pulseaudio-6.0
#nasm-2.11.08
#x_window_system
#glu-9.0.0
#aalib-1.4rc5
#pth-2.0.7
#directfb
#ggi
#svgalib-1.9.5
#libcaca
#jpicogui
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "sdl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.libsdl.org/release/SDL-1.2.15.tar.gz
# md5sum:
echo "9d96df8417572a2afb781a7c4c811a85 SDL-1.2.15.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf SDL-1.2.15.tar.gz
cd SDL-1.2.15
sed -i '/_XData32/s:register long:register _Xconst long:' src/video/x11/SDL_x11sym.h
./configure --prefix=/usr --disable-static --disable-sdl-dlopen
make
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/SDL-1.2.15/html
as_root install -v -m644    docs/html/*.html \
                    /usr/share/doc/SDL-1.2.15/html
cd ..
as_root rm -rf SDL-1.2.15
#
# Add to installed list for this computer:
echo "sdl-1.2.15" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

