#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for p11_kit-0.23.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#certdata
#libtasn1-4.5
#libffi-3.2.1
# End Recommended
# Begin Optional
#nss-3.20
#gtk_doc-1.24
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
grep p11_kit-0.23.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://p11-glue.freedesktop.org/releases/p11-kit-0.23.1.tar.gz
# md5sum:
echo "96f073270c489c9a594e1c9413f42db8 p11-kit-0.23.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf p11-kit-0.23.1.tar.gz
cd p11-kit-0.23.1
./configure --prefix=/usr --sysconfdir=/etc
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf p11-kit-0.23.1
#
# Add to installed list for this computer:
echo "p11_kit-0.23.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################