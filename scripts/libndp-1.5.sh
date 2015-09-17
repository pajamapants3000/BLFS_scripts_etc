#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libndp-1.5
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
grep libndp-1.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://libndp.org/files/libndp-1.5.tar.gz
#
# md5sum:
echo "beb82e8d75d8382d1b7c0bb0f68be429 libndp-1.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libndp-1.5.tar.gz
cd libndp-1.5
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libndp-1.5
#
# Add to installed list for this computer:
echo "libndp-1.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
