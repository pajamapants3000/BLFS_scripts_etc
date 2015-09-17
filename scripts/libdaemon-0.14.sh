#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libdaemon-0.14
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#lynx-2.8.8rel.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libdaemon-0.14 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz
#
# md5sum:
echo "509dc27107c21bcd9fbf2f95f5669563 libdaemon-0.14.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdaemon-0.14.tar.gz
cd libdaemon-0.14
./configure --prefix=/usr --disable-static
make
# with doxygen
#make -C doc doxygen
#
as_root make docdir=/usr/share/doc/libdaemon-0.14 install
# with doxygen
#as_root install -v -m755 -d /usr/share/doc/libdaemon-0.14/api
#as_root install -v -m644 doc/reference/html/* /usr/share/doc/libdaemon-0.14/api
#as_root install -v -m644 doc/reference/man/man3/* /usr/share/man/man3
#
cd ..
as_root rm -rf libdaemon-0.14
#
# Add to installed list for this computer:
echo "libdaemon-0.14" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################