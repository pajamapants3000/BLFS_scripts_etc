#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for openssl-1.0.2d
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
grep openssl-1.0.2d /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
#wget https://openssl.org/source/openssl-1.0.2d.tar.gz
# FTP/alt Download:
#wget ftp://openssl.org/source/openssl-1.0.2d.tar.gz
#
# md5sum:
echo "38dd619b2e77cbac69b99f52a053d25a openssl-1.0.2d.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf openssl-1.0.2d.tar.gz
cd openssl-1.0.2d
./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic
make
# Test:
make -j1 test
#
# Disable installing static libraries
#sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
as_root make MANDIR=/usr/share/man MANSUFFIX=ssl install
as_root install -dv -m755 /usr/share/doc/openssl-1.0.2d
as_root cp -vfr doc/*     /usr/share/doc/openssl-1.0.2d
cd ..
as_root rm -rf openssl-1.0.2d
#
# Add to installed list for this computer:
echo "openssl-1.0.2d" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
