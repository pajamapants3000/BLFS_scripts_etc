#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for fop-1.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep fop-1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://archive.apache.org/dist/xmlgraphics/fop/source/fop-1.1-src.tar.gz
# md5sum:
echo "7b63af514b28c06fe710a794cbf4d68e fop-1.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required download
wget http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz
# md5sum:
echo "4a906db35612f668aeef2c0606d7075b jai-1_1_3-lib-linux-amd64.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fop-1.1.tar.gz
cd fop-1.1
XXX
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf fop-1.1
#
# Add to installed list for this computer:
echo "fop-1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################