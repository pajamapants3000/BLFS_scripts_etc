#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for little_cms-2.7
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libjpeg_turbo-1.4.1
#tiff-4.0.5
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep little_cms-2.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lcms/lcms2-2.7.tar.gz
#
# md5sum:
echo "06c1626f625424a811fb4b5eb070839d lcms2-2.7.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lcms2-2.7.tar.gz
cd lcms2-2.7
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf lcms2-2.7
#
# Add to installed list for this computer:
echo "little_cms-2.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################