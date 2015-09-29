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
#xorg_server-1.17.2
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
grep twm-1.0.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/app/twm-1.0.9.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/app/twm-1.0.9.tar.bz2
#
# md5sum:
echo "59a6f076cdacb5f6945dac809bcf4906 twm-1.0.9.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf twm-1.0.9.tar.bz2
cd twm-1.0.9
sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in
./configure $XORG_CONFIG
make
#
as_root make install
cd ..
as_root rm -rf twm-1.0.9
#
# Add to installed list for this computer:
echo "twm-1.0.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################