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
#freetype-2.6
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#tiff-4.0.5
#little_cms-2.7
# End Recommended
# Begin Optional
#cairo-1.14.2
#cups-2.0.4
#fontconfig-2.11.1
#gtk+-2.24.28
#libidn-1.31
#libpaper-1.1.24+nmu4
#little_cms-1.19
#x_window_system
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ghostscript-9.16 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.ghostscript.com/public/ghostscript-9.16.tar.bz2
# md5sum:
echo "21732fd6e39acc283bc623b8842cbfbb ghostscript-9.16.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional downloads
# Standard fonts
wget http://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz
# Other fonts
wget http://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz
#
tar -xvf ghostscript-9.16.tar.bz2
cd ghostscript-9.16
sed -i 's/ZLIBDIR=src/ZLIBDIR=$includedir/' configure.ac configure
rm -rf freetype lcms2 jpeg libpng
rm -rf zlib expat
./configure --prefix=/usr --disable-compile-inits \
 --enable-dynamic --with-system-tiff
make
# Shared library depends on gtk+-2.24.28; to make it
#make so
#
as_root make install
# Install shared library as well
as_root make soinstall
as_root install -v -m644 base/*.h /usr/include/ghostscript
as_root ln -v -s ghostscript /usr/include/ps
#
as_root ln -sfv ../ghostscript/9.16/doc /usr/share/doc/ghostscript-9.16
# Install fonts
as_root tar -xvf ../ghostscript-fonts-std-8.11.tar.gz -C /usr/share/ghostscript --no-same-owner
fc-cache -v /usr/share/ghostscript/fonts/
as_root tar -xvf ../gnu-gs-fonts-other-6.0.tar.gz -C /usr/share/ghostscript --no-same-owner
fc-cache -v /usr/share/ghostscript/fonts/
cd ..
as_root rm -rf ghostscript-9.16
#
# Test the rendering of ps and pdf files, e.g
#gs -q -dBATCH /usr/share/ghostscript/9.16/examples/tiger.eps
# Add to installed list for this computer:
echo "ghostscript-9.16" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
