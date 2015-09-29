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
#xorg_libraries
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cups-2.0.4
#curl-7.44.0
#ffmpeg-2.7.1
#p7zip-9.38.1
#lzma
#sane-1.0.24
#wget-1.16.3
#xdg_utils-1.1.0-rc3
#xterm-320
#dmalloc
#electric fence
#fftw
#pgp
#gnupg-2.1.7 (you'll have to do some hacking to use gnupg)
#profiles
#ufraw
#jasper-1.900.1
#little_cms-1.19
#little_cms-2.7
#libexif-0.6.21
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#librsvg-2.40.10
#tiff-4.0.5
#libwebp-0.4.3
#openjpeg-2.1.0
#pango-1.36.8
#djvulibre
#flashpix
#jbig_kit
#libgxps
#liquid_rescale
#openexr
#ralcgm
#ghostscript-9.16
#gimp-2.8.14
#graphviz-2.38.0
#inkscape-0.91
#blender
#corefonts
#dejavu fonts
#ghostpcl
#gnuplot
#pov_ray
#radiance
#enscript-1.6.6
#texlive-20150521
#autotrace
#geoexpress
#mrsid
#hp2xx
#html2ps
#libwmf
#uniconvertor
#urt-3.1b
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep imagemagick-6.9.2-0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download is unreliable, so I keep a copy in sources/:
tar -xvf sources/ImageMagick-6.9.2-0.tar.xz
cd ImageMagick-6.9.2-0
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --enable-hdri     \
            --with-modules    \
            --with-perl       \
            --disable-static
make
#
as_root make DOCUMENTATION_PATH=/usr/share/doc/imagemagick-6.9.1 install
cd ..
as_root rm -rf ImageMagick-6.9.2-0
#
# Add to installed list for this computer:
echo "imagemagick-6.9.2-0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
