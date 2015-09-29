#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#gtk+-2.24.28
# End Required
# Begin Recommended
#libisoburn-1.4.0
#cdparanoia-III-10.2
#cdrdao-1.2.3
# End Recommended
# Begin Optional
#libcdio-0.93
#flac-1.3.1
#mpg123-1.22.2
#vorbis_tools-1.4.0
#lame-3.99.5
#mplayer-2015-02-20
#mpg321
#normalize
#cdrtools
#cdrkit
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep simpleburn-1.6.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://simpleburn.tuxfamily.org/IMG/bz2/simpleburn-1.6.5.tar.bz2
#
# md5sum:
echo "de658ab5af00e7bcb1e948d5c45da7b9 simpleburn-1.6.5.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf simpleburn-1.6.5.tar.bz2
cd simpleburn-1.6.5
sed -i -e 's|DESTINATION doc|DESTINATION share/doc|' CMakeLists.txt
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DBURNING=LIBBURNIA ..
make
#
as_root make install
cd ../..
as_root rm -rf simpleburn-1.6.5
#
# Add to installed list for this computer:
echo "simpleburn-1.6.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Add users to optical group for optical device access
#usermod -a -G cdrom <username>
#