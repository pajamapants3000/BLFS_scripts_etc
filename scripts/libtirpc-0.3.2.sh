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
#krb5-1.13.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libtirpc-0.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/project/libtirpc/libtirpc/0.3.2/libtirpc-0.3.2.tar.bz2
# md5sum:
echo "373d5ad46b1d19759ec763a9f0afcf4d libtirpc-0.3.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget  http://www.linuxfromscratch.org/patches/blfs/svn/libtirpc-0.3.2-api_fixes-1.patch
tar -xvf libtirpc-0.3.2.tar.bz2
cd libtirpc-0.3.2
patch -Np1 -i ../libtirpc-0.3.2-api_fixes-1.patch
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  \
            --disable-gssapi
make
#
as_root make install
as_root mv -v /usr/lib/libtirpc.so.* /lib
as_root ln -sfv ../../lib/libtirpc.so.1.0.10 /usr/lib/libtirpc.so
cd ..
as_root rm -rf libtirpc-0.3.2
#
# Add to installed list for this computer:
echo "libtirpc-0.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################