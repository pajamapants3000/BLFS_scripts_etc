#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for rpcbind-0.2.3
#
# Dependencies
#**************
# Begin Required
#libtirpc-0.3.2
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
grep rpcbind-0.2.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/rpcbind/rpcbind-0.2.3.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "c8875246b2688a1adfbd6ad43480278d rpcbind-0.2.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf rpcbind-0.2.3.tar.bz2
cd rpcbind-0.2.3
sed -i "/servname/s:rpcbind:sunrpc:" src/rpcbind.c
./configure --prefix=/usr       \
            --bindir=/sbin      \
            --with-rpcuser=root \
            --without-systemdsystemunitdir
make
#
as_root make install
cd ..
as_root rm -rf rpcbind-0.2.3
#
# Add to installed list for this computer:
echo "rpcbind-0.2.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-rpcbind
cd ..
#
###################################################