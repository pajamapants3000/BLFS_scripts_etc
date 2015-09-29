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
#hicolor_icon_theme-0.15
#libjpeg_turbo-1.4.1
#libpng-1.6.18
# End Recommended
# Begin Optional
#alsa_lib-1.0.29
#desktop_file_utils-0.22
#doxygen-1.8.10
#glu-9.0.0
#mesa-10.6.5
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "fltk-1.3.3" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://fltk.org/pub/fltk/1.3.3/fltk-1.3.3-source.tar.gz
# md5sum:
echo "9ccdb0d19dc104b87179bd9fd10822e3 fltk-1.3.3-source.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fltk-1.3.3-source.tar.gz
cd fltk-1.3.3
#
sed -i -e '/cat./d' documentation/Makefile
./configure --prefix=/usr    \
            --enable-shared
make
#
as_root make docdir=/usr/share/doc/fltk-1.3.3 install
cd ..
as_root rm -rf fltk-1.3.3
#
# Add to installed list for this computer:
echo "fltk-1.3.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#