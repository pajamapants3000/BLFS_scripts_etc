#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for alsa_lib-1.0.29
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#python-2.7.10
# End Optional
# Begin Kernel
#CONFIG_SOUND
#CONFIG_SND
#CONFIG_SOUND_PRIME
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep alsa_lib-1.0.29 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://alsa.cybermirror.org/lib/alsa-lib-1.0.29.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.29.tar.bz2
#
# md5sum:
echo "de67e0eca72474d6b1121037dafe1024 alsa-lib-1.0.29.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf alsa-lib-1.0.29.tar.bz2
cd alsa-lib-1.0.29
./configure
make
# with doxygen and want to build API docs
#make doc
# Test:
make check
#
as_root make install
# with doxygen, install API docs
#as_root install -v -d -m755 /usr/share/doc/alsa-lib-1.0.29/html/search
#as_root install -v -m644 doc/doxygen/html/*.* \
#                /usr/share/doc/alsa-lib-1.0.29/html
#as_root install -v -m644 doc/doxygen/html/search/* \
#                /usr/share/doc/alsa-lib-1.0.29/html/search
#
cd ..
as_root rm -rf alsa-lib-1.0.29
#
# Add to installed list for this computer:
echo "alsa_lib-1.0.29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
