#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libical-1.0.1
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
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
grep libical-1.0.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
#wget https://github.com/libical/libical/releases/download/v1.0.1/libical-1.0.1.tar.gz
# Last time I tried this download, the md5sum didn't match from two
#+different computers! I verified the backup source hosted by LFS was good:
wget http://anduin.linuxfromscratch.org/sources/BLFS/svn/l/libical-1.0.1.tar.gz
# md5sum:
echo "af91db06b22559f863869c5a382ad08a libical-1.0.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libical-1.0.1.tar.gz
cd libical-1.0.1
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DSHARED_ONLY=yes           \
      ..
make
# with doxygen
#make docs
#
# Test:
make test
#
as_root make install
# with doxygen
#as_root install -vdm755 /usr/share/doc/libical-1.0.1/html
#as_root cp -vr apidocs/html/* /usr/share/doc/libical-1.0.1/html
cd ../..
as_root rm -rf libical-1.0.1
#
# Add to installed list for this computer:
echo "libical-1.0.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
