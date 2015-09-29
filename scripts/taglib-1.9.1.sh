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
grep taglib-1.9.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/taglib/taglib/releases/download/v1.9.1/taglib-1.9.1.tar.gz
# md5sum:
echo "0d35df96822bbd564c5504cb3c2e4d86 taglib-1.9.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf taglib-1.9.1.tar.gz
cd taglib-1.9.1
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf taglib-1.9.1
#
# Add to installed list for this computer:
echo "taglib-1.9.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################