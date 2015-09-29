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
#freetype-2.6
#git-2.4.4
#glib-2.44.1
#libxml2-2.9.2
# End Required
# Begin Recommended
#cairo-1.14.2
#gtk+-2.24.28
#harfbuzz-0.9.41
#pango-1.36.8
#xorg_libraries
# End Recommended
# Begin Optional
#giflib-5.1.1
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#tiff-4.0.5
#python-2.7.10
#ipython
#libspiro
#libunicodenames
#libuninameslist
#libzmq
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "fontforge-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/fontforge/fontforge/releases/download/20150824/fontforge-20150824.tar.gz
#
# md5sum:
echo "74c49c73822d642b0511718d8eeb2210 fontforge-20150824.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fontforge-20150824.tar.gz
cd fontforge-20150824
if ( cat /list-$CHRISTENED-$SURNAME | grep gtk+-2 > /dev/null); then
./configure --prefix=/usr     \
            --enable-gtk2-use \
            --disable-static  \
            --docdir=/usr/share/doc/fontforge-20150824
else
./configure --prefix=/usr     \
            --disable-static  \
            --docdir=/usr/share/doc/fontforge-20150824
fi
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf fontforge-20150824
as_root sed -e '/Exec/ s/fontforge/& -new/' \
    -i /usr/share/applications/fontforge.desktop
#
# Add to installed list for this computer:
echo "fontforge-20150824" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

