#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libdvdread-5.0.3
#
# Dependencies
#**************
# Begin Required
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
grep libdvdread-5.0.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.videolan.org/videolan/libdvdread/5.0.3/libdvdread-5.0.3.tar.bz2
# md5sum:
echo "b7b7d2a782087ed2a913263087083715 libdvdread-5.0.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdvdread-5.0.3.tar.bz2
cd libdvdread-5.0.3
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdread-5.0.3
make
#
as_root make install
cd ..
as_root rm -rf libdvdread-5.0.3
#
# Add to installed list for this computer:
echo "libdvdread-5.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################