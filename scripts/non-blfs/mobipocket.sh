#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for mobipocket
#
# Dependencies
#**************
# Begin Required
#strigi-0.7.8
#kdelibs-4.14.10
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
grep mobipocket /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget -c http://anongit.kde.org/kdegraphics-mobipocket/kdegraphics-mobipocket-latest.tar.gz \
        -O mobipocket.tar.gz
#
tar -xvf mobipocket.tar.gz
cd kdegraphics-mobipocket
./initrepo.sh
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdegraphics-mobipocket
#
# Add to installed list for this computer:
echo "mobipocket" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################