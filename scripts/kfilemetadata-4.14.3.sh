#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kfilemetadata-4.14.3
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#taglib-1.9.1
#poppler-0.35.0
#xiv2-0.25
#ffmpeg-2.7.1
#libepub
#Mobipocket
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kfilemetadata-4.14.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/4.14.3/src/kfilemetadata-4.14.3.tar.xz
# md5sum:
echo "2e7143fd470bf84ac05475871119d9eb kfilemetadata-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kfilemetadata-4.14.3.tar.xz
cd kfilemetadata-4.14.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
# Test:
make test
#
as_root make install
cd ../..
as_root rm -rf kfilemetadata-4.14.3
#
# Add to installed list for this computer:
echo "kfilemetadata-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################