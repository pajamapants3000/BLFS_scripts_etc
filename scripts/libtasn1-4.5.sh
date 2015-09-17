#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libtasn1-4.5
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libtasn1-4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnu.org/gnu/libtasn1/libtasn1-4.5.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/libtasn1/libtasn1-4.5.tar.gz
#
# md5sum:
echo "81d272697545e82d39f6bd14854b68f0 libtasn1-4.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libtasn1-4.5.tar.gz
cd libtasn1-4.5
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libtasn1-4.5
#
# Add to installed list for this computer:
echo "libtasn1-4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################