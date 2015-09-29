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
#boost-1.59.0
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
grep clucene_core-2.3.3.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/clucene/clucene-core-2.3.3.4.tar.gz
# md5sum:
echo "48d647fbd8ef8889e5a7f422c1bfda94 clucene-core-2.3.3.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/clucene-2.3.3.4-contribs_lib-1.patch
tar -xvf clucene-core-2.3.3.4.tar.gz
cd clucene-core-2.3.3.4
patch -Np1 -i ../clucene-2.3.3.4-contribs_lib-1.patch
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DBUILD_CONTRIBS_LIB=ON ..
make
#
as_root make install
cd ../..
as_root rm -rf clucene-core-2.3.3.4
#
# Add to installed list for this computer:
echo "clucene_core-2.3.3.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################