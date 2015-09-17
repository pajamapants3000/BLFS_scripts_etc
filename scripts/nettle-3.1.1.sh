#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for nettle-3.1.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#openssl-1.0.2d
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep nettle-3.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.gnu.org/gnu/nettle/nettle-3.1.1.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/nettle/nettle-3.1.1.tar.gz
#
# md5sum:
echo "b40fa88dc32f37a182b6b42092ebb144 nettle-3.1.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf nettle-3.1.1.tar.gz
cd nettle-3.1.1
./configure --prefix=/usr
make
# Test:
make check
#
# Disable building static libs
#sed -i '/^install-here/ s/ install-static//' Makefile
#
as_root make install
as_root chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so
as_root install -v -m755 -d /usr/share/doc/nettle-3.1.1
as_root install -v -m644 nettle.html /usr/share/doc/nettle-3.1.1
cd ..
as_root rm -rf nettle-3.1.1
#
# Add to installed list for this computer:
echo "nettle-3.1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################