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
#babl-0.1.12
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cairo-1.14.2
#enscript-1.6.6
#exiv2-0.25
#ffmpeg-2.7.2
#gdk_pixbuf-2.31.6
#graphviz-2.38.0
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#librsvg-2.40.10
#lua-5.3.1
#pango-1.36.8
#python-2.7.10
#ruby-2.2.3
#sdl-1.2.15
#gobject_introspection-1.44.0
#vala-0.28.1
#w3m-0.5.3
#asciidoc
#lensfun
#libopenraw
#libspiro
#libumfpack
#openexr
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "gegl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.gimp.org/pub/gegl/0.2/gegl-0.2.0.tar.bz2
# Required patch download:
#wget http://www.linuxfromscratch.org/patches/blfs/svn/gegl-0.2.0-ffmpeg2-1.patch
#
# md5sum:
echo "32b00002f1f1e316115c4ed922e1dec8 gegl-0.2.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gegl-0.2.0.tar.bz2
cd gegl-0.2.0
#
patch -Np1 -i ../gegl-0.2.0-ffmpeg2-1.patch
./configure --prefix=/usr
LC_ALL=en_US make
# Test:
make check
#
as_root make install
as_root install -v -m644 docs/*.{css,html} /usr/share/gtk-doc/html/gegl
as_root install -d -v -m755 /usr/share/gtk-doc/html/gegl/images
as_root install -v -m644 docs/images/* /usr/share/gtk-doc/html/gegl/images
cd ..
as_root rm -rf gegl-0.2.0
#
# Add to installed list for this computer:
echo "gegl-0.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#