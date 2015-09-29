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
#libpng-1.6.18
#pixman-0.32.6 
# End Required
# Begin Recommended
#fontconfig-2.11.1
#glib-2.44.1
#Xorg Libraries 
# End Recommended
# Begin Optional
#cogl-1.20.0
#gtk_doc-1.24
#libdrm-2.4.64
#lzo-2.09
#mesa-10.6.5
#qt-4.8.7
#valgrind-3.10.1
#directfb
#jbig2dec
#skia 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep cairo-1.14.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cairographics.org/releases/cairo-1.14.2.tar.xz
# md5sum:
echo "e1cdfaf1c6c995c4d4c54e07215b0118 cairo-1.14.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf cairo-1.14.2.tar.xz
cd cairo-1.14.2
./configure --prefix=/usr    \
            --disable-static \
            --enable-tee
make
#
as_root make install
cd ..
as_root rm -rf cairo-1.14.2
#
# Add to installed list for this computer:
echo "cairo-1.14.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################