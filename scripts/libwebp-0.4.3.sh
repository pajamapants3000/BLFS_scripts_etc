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
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#tiff-4.0.5
# End Recommended
# Begin Optional
#freeglut-3.0.0
#giflib-5.1.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libwebp-0.4.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.webmproject.org/releases/webp/libwebp-0.4.3.tar.gz
# md5sum:
echo "08813525eeeffe7e305b4cbfade8ae9b libwebp-0.4.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libwebp-0.4.3.tar.gz
cd libwebp-0.4.3
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libwebp-0.4.3
#
# Add to installed list for this computer:
echo "libwebp-0.4.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################