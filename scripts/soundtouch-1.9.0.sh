#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for soundtouch-1.9.0
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
grep soundtouch-1.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.surina.net/soundtouch/soundtouch-1.9.0.tar.gz
# md5sum:
echo "0b0672c09c1c97df2e61c4d5aa9a7b86 soundtouch-1.9.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf soundtouch-1.9.0.tar.gz
cd soundtouch-1.9.0
./bootstrap
./configure --prefix=/usr --docdir=/usr/share/doc/soundtouch-1.9.0
make
#
as_root make install
cd ..
as_root rm -rf soundtouch-1.9.0
#
# Add to installed list for this computer:
echo "soundtouch-1.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################