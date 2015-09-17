#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libvpx-1.4.0
#
# Dependencies
#**************
# Begin Required
#yasm-1.3.0
#which-2.21
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#php-5.6.12
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libvpx-1.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.4.0.tar.bz2
# md5sum:
echo "63b1d7f59636a42eeeee9225cc14e7de libvpx-1.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libvpx-1.4.0.tar.bz2
cd libvpx-1.4.0
sed   -e 's/cp -p/cp/'       \
      -i build/make/Makefile
chmod -v 644 vpx/*.h
mkdir ../libvpx-build
cd    ../libvpx-build
../libvpx-1.4.0/configure --prefix=/usr \
                           --enable-shared \
                           --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libvpx-1.4.0
as_root rm -rf libvpx-build
#
# Add to installed list for this computer:
echo "libvpx-1.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################