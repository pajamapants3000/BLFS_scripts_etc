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
#fontconfig-2.11.1
# End Required
# Begin Recommended
#cairo-1.14.2
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#openjpeg-1.5.2
# End Recommended
# Begin Optional
#curl-7.44.0
#gobject_introspection-1.44.0
#gtk_doc-1.24
#gtk+-2.24.28
#little_cms-1.19
#little_cms-2.7
#tiff-4.0.5
#openjpeg-2.1.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep poppler-0.35.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://poppler.freedesktop.org/poppler-0.35.0.tar.xz
# md5sum:
echo "561ef4454bfabe59ef1b8b9cd4aa4c4b poppler-0.35.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Encoding data download:
wget http://poppler.freedesktop.org/poppler-data-0.4.7.tar.gz
# md5sum:
echo "636a8f2b9f6df9e7ced8ec0946961eaf poppler-data-0.4.7.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf poppler-0.35.0.tar.xz
cd poppler-0.35.0
#
# Download test files
rm -rf testfiles &&
git clone git://git.freedesktop.org/git/poppler/test testfiles
# Build with support for ONLY qt4
#source /usr/bin/setqt4
# Remove MOCQT5 from configure
#
# Build with support for ONLY qt5
#source /usr/bin/setqt5
# Remove MOCQT4 from configure
#
# Build with support for both:
#
MOCQT4=$QT4DIR/bin/moc            \
MOCQT5=$QT5DIR/bin/moc            \
./configure --prefix=/usr         \
            --sysconfdir=/etc     \
            --disable-static      \
            --enable-xpdf-headers \
            --enable-zlib         \
            --enable-libcurl      \
            --disable-gtk-test    \
            --with-testdatadir=$PWD/testfiles
make
# Test:
LC_ALL=en_US.UTF-8 make check
#
as_root make install
as_root install -v -m755 -d        /usr/share/doc/poppler-0.35.0
as_root install -v -m644 README*   /usr/share/doc/poppler-0.35.0
as_root cp -vr glib/reference/html /usr/share/doc/poppler-0.35.0
tar -xf ../poppler-data-0.4.7.tar.gz
cd poppler-data-0.4.7
as_root make prefix=/usr install
cd ..
as_root rm -rf poppler-0.35.0
#
# Add to installed list for this computer:
echo "poppler-0.35.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
