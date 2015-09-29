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
#openssl-1.0.2d
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
grep libevent-2.0.22 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/levent/libevent-2.0.22-stable.tar.gz
# md5sum:
echo "c4c56f986aa985677ca1db89630a2e11 libevent-2.0.22.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libevent-2.0.22.tar.gz
cd libevent-2.0.22
./configure --prefix=/usr --disable-static
make
# with doxygon, build API doc
#doxygen Doxyfile
# Test:
# Tests fail: dns/gethostbyaddr and dns/resolve_reverse
#make verify
#
as_root make install
# with doxygen, install API doc
#as_root install -v -m755 -d /usr/share/doc/libevent-2.0.22/api
#as_root cp      -v -R       doxygen/html/* \
#                    /usr/share/doc/libevent-2.0.22/api
cd ..
as_root rm -rf libevent-2.0.22
#
# Add to installed list for this computer:
echo "libevent-2.0.22" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
