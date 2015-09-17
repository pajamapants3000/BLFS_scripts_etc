#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for openjpeg-2.1.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
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
grep openjpeg-2.1.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/openjpeg.mirror/openjpeg-2.1.0.tar.gz
# md5sum:
echo "f6419fcc233df84f9a81eb36633c6db6 openjpeg-2.1.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf openjpeg-2.1.0.tar.gz
cd openjpeg-2.1.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..
make
#
as_root make install
pushd ../doc
for man in man/man?/* ; do
    as_root install -v -D -m 644 $man /usr/share/$man
done
popd
cd ../..
as_root rm -rf openjpeg-2.1.0
#
# Add to installed list for this computer:
echo "openjpeg-2.1.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
