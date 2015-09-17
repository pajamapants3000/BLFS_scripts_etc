#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for fdk_aac-0.1.4
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
grep "fdk_aac-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/opencore-amr/fdk-aac-0.1.4.tar.gz
# md5sum:
echo "e274a7d7f6cd92c71ec5c78e4dc9f8b7 fdk-aac-0.1.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fdk-aac-0.1.4.tar.gz
cd fdk-aac-0.1.4
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf fdk-aac-0.1.4
#
# Add to installed list for this computer:
echo "fdk_aac-0.1.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

