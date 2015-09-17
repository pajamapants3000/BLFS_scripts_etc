#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Installation script for libxslt-1.1.28
#
# Dependencies
#**************
# Begin Required
#libxml2-2.9.2
# End Required
# Begin Recommended
#docbook_xml-4.5
#docbook_xsl-1.78.1
# End Recommended
# Begin Optional
#libgcrypt-1.6.2
#python-2.7.9
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libxslt-1.1.28 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz
# FTP/alt Download:
#wget ftp://xmlsoft.org/libxslt/libxslt-1.1.28.tar.gz
#
# md5sum:
echo "9667bf6f9310b957254fdcf6596600b7 libxslt-1.1.28.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxslt-1.1.28.tar.gz
cd libxslt-1.1.28
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libxslt-1.1.28
#
# Add to installed list for this computer:
echo "libxslt-1.1.28" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################