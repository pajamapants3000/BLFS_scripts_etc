#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#curl-7.44.0
#libarchive-3.1.2
# End Recommended
# Begin Optional
#qt-4.8.7
#qt-5.5.0
#subversion-1.8.13
#sphinx
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "cmake-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.cmake.org/files/v3.3/cmake-3.3.1.tar.gz
# md5sum:
echo "52638576f4e1e621fed6c3410d3a1b12 cmake-3.3.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf cmake-3.3.1.tar.gz
cd cmake-3.3.1
if (cat /list-${CHRISTENED}-${SURNAME} | grep "qt-" > /dev/null); then
# Set desired qt version if necessary
#source setqt5
./bootstrap --prefix=/usr       \
            --system-libs       \
            --mandir=/share/man \
            --no-system-jsoncpp \
            --qt-gui            \
            --docdir=/share/doc/cmake-3.3.1
else
./bootstrap --prefix=/usr       \
            --system-libs       \
            --mandir=/share/man \
            --no-system-jsoncpp \
            --docdir=/share/doc/cmake-3.3.1
fi
make -j${PARALLEL}
# Test:
bin/ctest -j5 -O ../cmake-3.3.1-test.log
#
as_root make install
cd ..
as_root rm -rf cmake-3.3.1
#
# Add to installed list for this computer:
echo "cmake-3.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
