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
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep haveged-1.9.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/project/haveged/haveged-1.9.1.tar.gz
# md5sum:
echo "015ff58cd10607db0e0de60aeca2f5f8 haveged-1.9.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf haveged-1.9.1.tar.gz
cd haveged-1.9.1
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
as_root mkdir -pv    /usr/share/doc/haveged-1.9.1
as_root cp -v README /usr/share/doc/haveged-1.9.1
cd ..
as_root rm -rf haveged-1.9.1
#
# Add to installed list for this computer:
echo "haveged-1.9.1" >> /list-$CHRISTENED"-"$SURNAME
#
cd blfs-bootscripts-20150823
as_root make install-haveged
###################################################