#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for nss-3.20
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#nspr-4.10.9
# End Required
# Begin Recommended
#sqlite-3.8.11.1
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
grep "nss-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_20_RTM/src/nss-3.20.tar.gz
# FTP/alt Download:
#wget ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_20_RTM/src/nss-3.20.tar.gz
#
# md5sum:
echo "db83988499d1eb3b623d77ecf495b0f5 nss-3.20.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/nss-3.20-standalone-1.patch
tar -xvf nss-3.20.tar.gz
pushd nss-3.20
patch -Np1 -i ../nss-3.20-standalone-1.patch
cd nss
make BUILD_OPT=1                      \
  NSPR_INCLUDE_DIR=/usr/include/nspr  \
  USE_SYSTEM_ZLIB=1                   \
  ZLIB_LIBS=-lz                       \
  $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
  $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1) -j1
#
cd ../dist
as_root install -v -m755 Linux*/lib/*.so              /usr/lib
as_root install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib
as_root install -v -m755 -d                           /usr/include/nss
as_root cp -v -RL {public,private}/nss/*              /usr/include/nss
as_root chmod -v 644                                  /usr/include/nss/*
as_root install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin
as_root install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig
popd
as_root rm -rf nss-3.20
#
# Add to installed list for this computer:
echo "nss-3.20" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
