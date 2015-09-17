#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libmpdclient-2.9
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
grep "libmpdclient-2.9" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.musicpd.org/download/libmpdclient/2/libmpdclient-2.9.tar.xz
# md5sum:
#echo "XXX libmpdclient-2.9.tar.xz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libmpdclient-2.9.tar.xz
cd libmpdclient-2.9
./configure --prefix=/usr --disable-documentation
make
#
as_root make install
cd ..
as_root rm -rf libmpdclient-2.9
#
# Add to installed list for this computer:
echo "libmpdclient-2.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


