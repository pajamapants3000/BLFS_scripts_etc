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
#libdvdread-5.0.3
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libdvdnav-5.0.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.videolan.org/videolan/libdvdnav/5.0.3/libdvdnav-5.0.3.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "e9ea4de3bd8f204e61301d407d09f033 libdvdnav-5.0.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdvdnav-5.0.3.tar.bz2
cd libdvdnav-5.0.3
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdnav-5.0.3
make
#
as_root make install
cd ..
as_root rm -rf libdvdnav-5.0.3
#
# Add to installed list for this computer:
echo "libdvdnav-5.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################