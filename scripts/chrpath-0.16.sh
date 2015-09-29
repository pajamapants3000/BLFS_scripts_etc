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
grep "chrpath-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://alioth.debian.org/frs/download.php/latestfile/813/chrpath-0.16.tar.gz
# md5sum:
echo "2bf8d1d1ee345fc8a7915576f5649982 chrpath-0.16.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf chrpath-0.16.tar.gz
cd chrpath-0.16
./configure --prefix=/usr
make
#
as_root make docdir=/usr/share/doc/chrpath-0.16 install
cd ..
as_root rm -rf chrpath-0.16
#
# Add to installed list for this computer:
echo "chrpath-0.16" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


