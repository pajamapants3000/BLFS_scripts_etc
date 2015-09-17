#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libmad-0.15.1b
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
grep "libmad-0.15.1b" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/mad/libmad-0.15.1b.tar.gz
# FTP/alt Download:
#wget ftp://ftp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz
#
# md5sum:
echo "1be543bc30c56fb6bea1d7bf6a64e66c libmad-0.15.1b.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/libmad-0.15.1b-fixes-1.patch
#
tar -xvf libmad-0.15.1b.tar.gz
cd libmad-0.15.1b
#
patch -Np1 -i ../libmad-0.15.1b-fixes-1.patch
sed "s@AM_CONFIG_HEADER@AC_CONFIG_HEADERS@g" -i configure.ac
touch NEWS AUTHORS ChangeLog
autoreconf -fi
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libmad-0.15.1b
#
# Add to installed list for this computer:
echo "libmad-0.15.1b" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
as_root install -Dm644 -o root -g root \
    files/mad.pc /usr/lib/pkgconfig/mad.pc
#
###################################################

