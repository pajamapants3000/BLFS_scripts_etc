#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libisoburn-1.4.0
#
# Dependencies
#**************
# Begin Required
#libburn-1.4.0
#libisofs-1.4.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#tk-8.6.4
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libisoburn-1.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://files.libburnia-project.org/releases/libisoburn-1.4.0.tar.gz
#
# md5sum:
echo "77bc6bcbe023ccd0fb210e341606dfbf libisoburn-1.4.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libisoburn-1.4.0.tar.gz
cd libisoburn-1.4.0
./configure --prefix=/usr              \
            --disable-static           \
            --enable-pkg-check-modules
make
# with doxygen
#doxygen doc/doxygen.conf
#
as_root make install
# with doxygen
#as_root install -v -dm755 /usr/share/doc/libisoburn-1.4.0
#as_root install -v -m644 doc/html/* /usr/share/doc/libisoburn-1.4.0
#
cd ..
as_root rm -rf libisoburn-1.4.0
#
# Add to installed list for this computer:
echo "libisoburn-1.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################