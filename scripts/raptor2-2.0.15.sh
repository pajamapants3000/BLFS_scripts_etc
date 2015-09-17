#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for raptor2-2.0.15
#
# Dependencies
#**************
# Begin Required
#curl-7.44.0
#libxslt-1.1.28
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
#icu-55.1
#yajl 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep raptor2-2.0.15 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.librdf.org/source/raptor2-2.0.15.tar.gz
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "a39f6c07ddb20d7dd2ff1f95fa21e2cd raptor2-2.0.15.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf raptor2-2.0.15.tar.gz
cd raptor2-2.0.15
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf raptor2-2.0.15
#
# Add to installed list for this computer:
echo "raptor2-2.0.15" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################