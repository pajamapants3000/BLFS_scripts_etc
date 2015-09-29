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
#libffi-3.2.1
#nspr-4.10.9
#python-2.7.10
#zip-3.0
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
grep js-17.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.gz
# FTP/alt Download:
#wget ftp://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.gz
#
# md5sum:
echo "20b6f8f1140ef6e47daa3b16965c9202 mozjs17.0.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf mozjs17.0.0.tar.gz
cd mozjs17.0.0
cd js/src
sed -i 's/(defined\((@TEMPLATE_FILE)\))/\1/' config/milestone.pl
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
find /usr/include/js-17.0/            \
     /usr/lib/libmozjs-17.0.a         \
     /usr/lib/pkgconfig/mozjs-17.0.pc \
     -type f -exec as_root chmod -v 644 {} \;
cd ../../..
as_root rm -rf mozjs17.0.0
#
# Add to installed list for this computer:
echo "js-17.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
