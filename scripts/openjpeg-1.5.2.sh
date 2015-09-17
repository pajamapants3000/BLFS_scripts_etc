#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for openjpeg-1.5.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#little_cms-2.7
#libpng-1.6.18
#tiff-4.0.5
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep openjpeg-1.5.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/openjpeg.mirror/openjpeg-1.5.2.tar.gz
# md5sum:
echo "c41772c30fb1c272358b3707233134a1 openjpeg-1.5.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf openjpeg-1.5.2.tar.gz
cd openjpeg-1.5.2
autoreconf -f -i
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf openjpeg-1.5.2
#
# Add to installed list for this computer:
echo "openjpeg-1.5.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
