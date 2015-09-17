#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qpdf-5.1.3
#
# Dependencies
#**************
# Begin Required
#pcre-8.37
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#fop-1.1
#libxslt-1.1.28
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qpdf-5.1.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/qpdf/qpdf-5.1.3.tar.gz
# md5sum:
echo "aafbf3950230f84d7998b700b12428f4 qpdf-5.1.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qpdf-5.1.3.tar.gz
cd qpdf-5.1.3
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/qpdf-5.1.3
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf qpdf-5.1.3
#
# Add to installed list for this computer:
echo "qpdf-5.1.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################