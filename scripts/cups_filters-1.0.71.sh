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
#cups-2.0.4
#glib-2.44.1
#ijs-0.35
#little_cms-2.7
#poppler-0.35.0
#qpdf-5.1.3
# End Required
# Begin Recommended
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#tiff-4.0.5
#ghostscript-9.16
#gutenprint-5.2.10
# End Recommended
# Begin Optional
#avahi-0.6.31
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
grep cups_filters-1.0.71 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.openprinting.org/download/cups-filters/cups-filters-1.0.71.tar.xz
# md5sum:
echo "f1e11dfe5fa52eb65aa0bdd3a7ee0117 cups-filters-1.0.71.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf cups-filters-1.0.71.tar.xz
cd cups-filters-1.0.71
./configure --prefix=/usr                   \
            --sysconfdir=/etc               \
            --localstatedir=/var            \
            --without-rcdir                 \
            --disable-static                \
            --with-gs-path=/usr/bin/gs      \
            --with-pdftops-path=/usr/bin/gs \
            --docdir=/usr/share/doc/cups-filters-1.0.71
make
# Test:
make check 2>&1 >testlog
#
as_root make install
cd ..
as_root rm -rf cups-filters-1.0.71
#
# Add to installed list for this computer:
echo "cups_filters-1.0.71" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################