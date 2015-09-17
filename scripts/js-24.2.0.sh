#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for js-24.2.0
#
# Dependencies
#**************
# Begin Required
#libffi-3.2.1
#nspr-4.10.9
#python-2.7.9
#zip-3.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep js-24.2.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2
#
# md5sum:
echo "5db79c10e049a2dc117a6e6a3bc78a8e mozjs-24.2.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf mozjs-24.2.0.tar.bz2
cd mozjs-24.2.0
cd js/src
./configure --prefix=/usr       \
            --enable-readline   \
            --enable-threadsafe \
            --with-system-ffi   \
            --with-system-nspr
make
# Test:
make check
#
as_root make install
find /usr/include/mozjs-24/         \
     /usr/lib/libmozjs-24.a         \
     /usr/lib/pkgconfig/mozjs-24.pc \
     -type f -exec as_root chmod -v 644 {} \;
cd ..
as_root rm -rf mozjs-24.2.0
#
# Add to installed list for this computer:
echo "js-24.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################