#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for at_spi2_atk-2.16.0
#
# Dependencies
#**************
# Begin Required
#at_spi2_core-2.16.0
#atk-2.16.0
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
grep at_spi2_atk-2.16.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/2.16/at-spi2-atk-2.16.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/2.16/at-spi2-atk-2.16.0.tar.xz
#
# md5sum:
echo "8936488c8cdce0e158f80b2e247527f9 at-spi2-atk-2.16.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf at-spi2-atk-2.16.0.tar.xz
cd at-spi2-atk-2.16.0
./configure --prefix=/usr
make
# Test (requires active graphical session with bus address):
#make check
#
as_root make install
cd ..
as_root rm -rf at-spi2-atk-2.16.0
#
# Add to installed list for this computer:
echo "at_spi2_atk-2.16.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################